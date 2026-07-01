#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(realpath "$SCRIPT_DIR/../..")"

source "$BASE_DIR/core/ui.sh"
source "$BASE_DIR/core/functions.sh"

clear

title "PasarGuard Status"

########################################
# System
########################################

HOSTNAME=$(hostname)
IP=$(hostname -I | awk '{print $1}')
OS=$(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')
KERNEL=$(uname -r)
UPTIME=$(uptime -p)
CPU=$(grep "model name" /proc/cpuinfo | head -1 | cut -d: -f2 | xargs)
RAM=$(free -h | awk '/Mem:/ {print $3 " / " $2}')
DISK=$(df -h / | awk 'NR==2 {print $3 " / " $2 " (" $5 ")"}')
LOAD=$(uptime | awk -F'load average:' '{print $2}' | xargs)

echo "System"
echo "----------------------------------------"
echo "Hostname        : $HOSTNAME"
echo "IP Address      : $IP"
echo "Operating System: $OS"
echo "Kernel          : $KERNEL"
echo "Uptime          : $UPTIME"
echo "CPU             : $CPU"
echo "Memory          : $RAM"
echo "Disk            : $DISK"
echo "CPU Load        : $LOAD"

echo
echo "Services"
echo "----------------------------------------"

########################################
# Docker
########################################

if systemctl is-active --quiet docker; then
    DOCKER_STATUS="✓ Running"
else
    DOCKER_STATUS="✗ Stopped"
fi

echo "Docker          : $DOCKER_STATUS"

########################################
# Panel
########################################

if docker exec pasarguard-pasarguard-1 curl -fs http://localhost:8000/ >/dev/null 2>&1; then
    PANEL_STATUS="✓ Healthy"
else
    PANEL_STATUS="✗ Unhealthy"
fi

echo "Panel           : $PANEL_STATUS"

########################################
# Database
########################################

if docker ps --format "{{.Names}}" | grep -q "timescaledb"; then
    DB_STATUS="✓ TimescaleDB"
else
    DB_STATUS="✗ Offline"
fi

echo "Database        : $DB_STATUS"

########################################
# PgBouncer
########################################

if docker ps --format "{{.Names}}" | grep -q "pgbouncer"; then
    PGB_STATUS="✓ Running"
else
    PGB_STATUS="✗ Offline"
fi

echo "PgBouncer       : $PGB_STATUS"

########################################
# PasarGuard
########################################

echo
echo "PasarGuard"
echo "----------------------------------------"

VERSION=$(docker exec pasarguard-pasarguard-1 python -c "import app;print(app.__version__)" 2>/dev/null)

[ -z "$VERSION" ] && VERSION="Unknown"

echo "Version         : $VERSION"

NODE_COUNT=$(docker exec pasarguard-pasarguard-1 python - <<EOF 2>/dev/null
from app.db import GetDB
from app.models.node import Node

db = GetDB()
print(db.query(Node).count())
EOF
)

[ -z "$NODE_COUNT" ] && NODE_COUNT=0

if [ "$NODE_COUNT" -eq 0 ]; then
    echo "Nodes           : 0 (No nodes configured)"
else
    echo "Nodes           : $NODE_COUNT"
fi

########################################
# Containers
########################################

echo
echo "Docker Containers"
echo "----------------------------------------"

printf "%-30s %-15s\n" "NAME" "STATUS"

docker ps --format "{{.Names}}|{{.Status}}" | while IFS="|" read -r NAME STATUS
do
    case "$STATUS" in
        *healthy*)
            ICON="✓ Healthy"
            ;;
        Up*)
            ICON="✓ Running"
            ;;
        *)
            ICON="✗ Stopped"
            ;;
    esac

    printf "%-30s %-15s\n" "$NAME" "$ICON"
done

echo
echo "----------------------------------------"

pause
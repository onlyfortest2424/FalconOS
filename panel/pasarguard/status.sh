#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(realpath "$SCRIPT_DIR/../..")"

source "$BASE_DIR/core/ui.sh"
source "$BASE_DIR/core/functions.sh"

clear

title "PasarGuard Status"

########################################
# System Information
########################################

HOSTNAME=$(hostname)
IP=$(hostname -I | awk '{print $1}')
OS=$(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')
KERNEL=$(uname -r)
UPTIME=$(uptime -p)
CPU=$(grep "model name" /proc/cpuinfo | head -1 | cut -d: -f2 | xargs)
RAM=$(free -h | awk '/Mem:/ {print $3 " / " $2}')
DISK=$(df -h / | awk 'NR==2 {print $3 " / " $2 " (" $5 ")"}')
LOAD=$(uptime | awk -F'load average:' '{print $2}')

echo "Hostname        : $HOSTNAME"
echo "IP Address      : $IP"
echo "Operating System: $OS"
echo "Kernel          : $KERNEL"
echo "Uptime          : $UPTIME"
echo "CPU             : $CPU"
echo "Memory          : $RAM"
echo "Disk            : $DISK"
echo "CPU Load        :$LOAD"

echo
echo "----------------------------------------"
echo "Services"
echo "----------------------------------------"

########################################
# Docker
########################################

if systemctl is-active --quiet docker; then
    echo "Docker          : Running"
else
    echo "Docker          : Stopped"
fi

########################################
# Panel
########################################

if docker ps --format '{{.Names}}' | grep -q "pasarguard-pasarguard"; then
    echo "Panel           : Running"
else
    echo "Panel           : Stopped"
fi

########################################
# Database
########################################

DB="Unknown"

if docker ps --format '{{.Names}}' | grep -q "timescaledb"; then
    DB="TimescaleDB"
elif docker ps --format '{{.Names}}' | grep -qi postgres; then
    DB="PostgreSQL"
elif docker ps --format '{{.Names}}' | grep -qi mariadb; then
    DB="MariaDB"
elif docker ps --format '{{.Names}}' | grep -qi mysql; then
    DB="MySQL"
elif docker ps --format '{{.Names}}' | grep -qi sqlite; then
    DB="SQLite"
fi

echo "Database        : $DB"

########################################
# PgBouncer
########################################

if ! docker ps >/dev/null 2>&1; then
    echo "Docker          : Not Installed"
    echo
    pause
    exit 0
fi

########################################
# Version
########################################

VERSION=$(docker exec pasarguard-pasarguard-1 python -c "import app;print(app.__version__)" 2>/dev/null)

if [ -z "$VERSION" ]; then
    VERSION="Unknown"
fi

echo "Panel Version   : $VERSION"

########################################
# Nodes
########################################

NODE_COUNT=$(docker exec pasarguard-pasarguard-1 python - <<EOF 2>/dev/null
from app.db import GetDB
from app.models.node import Node
db=GetDB()
print(db.query(Node).count())
EOF
)

[ -z "$NODE_COUNT" ] && NODE_COUNT="0"

echo "Nodes           : $NODE_COUNT"

echo
echo "----------------------------------------"
echo "Docker Containers"
echo "----------------------------------------"

docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Image}}"

echo

pause
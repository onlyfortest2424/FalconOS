#!/usr/bin/env bash

BASE_DIR="$(cd "$(dirname "$0")/../../.." && pwd)"

source "$BASE_DIR/core/ui.sh"
source "$BASE_DIR/core/functions.sh"

pasarguard_status() {

clear

title "PasarGuard Status"

echo

########################################
# Docker
########################################

if systemctl is-active --quiet docker; then
    echo "Docker        : Running"
else
    echo "Docker        : Stopped"
fi

########################################
# Panel
########################################

if docker ps --format '{{.Names}}' | grep -q "pasarguard-pasarguard"; then
    echo "Panel         : Running"
else
    echo "Panel         : Stopped"
fi

########################################
# TimescaleDB
########################################

if docker ps --format '{{.Names}}' | grep -q "timescaledb"; then
    echo "Database      : TimescaleDB"
else
    echo "Database      : Not Running"
fi

########################################
# PgBouncer
########################################

if docker ps --format '{{.Names}}' | grep -q "pgbouncer"; then
    echo "PgBouncer     : Running"
else
    echo "PgBouncer     : Not Running"
fi

########################################
# Version
########################################

VERSION=$(docker exec pasarguard-pasarguard-1 python -c "import app;print(app.__version__)" 2>/dev/null)

if [ -n "$VERSION" ]; then
    echo "Version       : $VERSION"
fi

echo
echo "Containers"
echo "---------------------------"

docker ps --format "table {{.Names}}\t{{.Status}}"

echo

pause

}

pasarguard_status
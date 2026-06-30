#!/usr/bin/env bash

BASE_DIR="$(cd "$(dirname "$0")/../../.." && pwd)"

source "$BASE_DIR/core/ui.sh"
source "$BASE_DIR/core/functions.sh"

LOG_FILE="/var/log/falconos_pasarguard_install.log"

exec > >(tee -a "$LOG_FILE") 2>&1

title "PasarGuard Panel Installer"

echo "Log File: $LOG_FILE"
echo

echo "[1/5] Root Check"
require_root
ok "Root Access Verified"

echo "[2/5] Operating System Check"
check_os
ok "Ubuntu Supported"

echo "[3/5] Internet Connectivity Check"
check_internet
ok "Internet Connected"

echo "[4/5] Downloading Official Installer"

INSTALLER="/tmp/pasarguard.sh"

rm -f "$INSTALLER"

curl -fsSL https://github.com/PasarGuard/scripts/raw/main/pasarguard.sh -o "$INSTALLER"

if [ $? -ne 0 ]; then
    error "Failed to download official installer."
fi

if [ ! -s "$INSTALLER" ]; then
    error "Downloaded installer is empty."
fi

chmod +x "$INSTALLER"

ok "Official Installer Downloaded"

echo
echo "======================================"
echo "      Database Selection"
echo "======================================"
echo
echo " [1] TimescaleDB ⭐ Recommended (Default)"
echo " [2] PostgreSQL"
echo " [3] MariaDB"
echo " [4] MySQL"
echo " [5] SQLite"
echo

read -rp "Choose [1]: " DB

case "$DB" in
    ""|1)
        DB_TYPE="timescaledb"
        ;;
    2)
        DB_TYPE="postgresql"
        ;;
    3)
        DB_TYPE="mariadb"
        ;;
    4)
        DB_TYPE="mysql"
        ;;
    5)
        DB_TYPE="sqlite"
        ;;
    *)
        DB_TYPE="timescaledb"
        ;;
esac

echo
echo "Selected Database : $DB_TYPE"
echo

echo "[5/5] Running Official Installer"

bash "$INSTALLER" install --database "$DB_TYPE"

INSTALL_EXIT_CODE=$?

echo

if [ $INSTALL_EXIT_CODE -ne 0 ]; then
    error "PasarGuard installer exited with code $INSTALL_EXIT_CODE"
fi

ok "Official Installer Finished"

echo
echo "Checking Installation..."
echo

if command -v docker >/dev/null 2>&1; then
    ok "Docker Installed"
else
    warn "Docker Not Found"
fi

if [ -d /opt/pasarguard ]; then
    ok "PasarGuard Directory Created"
else
    warn "PasarGuard Directory Not Found"
fi

if command -v pasarguard >/dev/null 2>&1; then
    ok "PasarGuard CLI Installed"
else
    warn "PasarGuard CLI Not Found"
fi

if systemctl list-unit-files | grep -qi docker; then
    ok "Docker Service Installed"
else
    warn "Docker Service Not Found"
fi

echo
echo "======================================"
echo " Installation Finished"
echo "======================================"
echo
echo "Log File : $LOG_FILE"
echo

pause
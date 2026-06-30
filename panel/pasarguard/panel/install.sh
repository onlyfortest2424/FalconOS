#!/usr/bin/env bash

BASE_DIR="$(cd "$(dirname "$0")/../../.." && pwd)"

source "$BASE_DIR/core/ui.sh"
source "$BASE_DIR/core/functions.sh"

LOG_FILE="/var/log/falconos_pasarguard_install.log"

exec > >(tee -a "$LOG_FILE") 2>&1

title "PasarGuard Panel Installer"

echo "Log File: $LOG_FILE"
echo

echo "[1/4] Root Check"
require_root
ok "Root Access Verified"

echo "[2/4] Operating System Check"
check_os
ok "Ubuntu Supported"

echo "[3/4] Internet Connectivity Check"
check_internet
ok "Internet Connected"

echo "[4/4] Downloading Official PasarGuard Installer"

INSTALLER="/tmp/pasarguard.sh"

rm -f "$INSTALLER"

curl -fsSL \
https://github.com/PasarGuard/scripts/raw/main/pasarguard.sh \
-o "$INSTALLER"

if [ $? -ne 0 ]; then
    error "Failed to download official installer."
fi

if [ ! -s "$INSTALLER" ]; then
    error "Downloaded installer is empty."
fi

chmod +x "$INSTALLER"

ok "Official Installer Downloaded"

echo
echo "Running Official Installer..."
echo

bash "$INSTALLER"

INSTALL_EXIT_CODE=$?

echo

if [ $INSTALL_EXIT_CODE -ne 0 ]; then
    error "PasarGuard installer exited with code $INSTALL_EXIT_CODE"
fi

ok "Official Installer Finished"

echo

echo "Checking Installation..."

if command -v pasarguard >/dev/null 2>&1; then
    ok "PasarGuard CLI Installed"
else
    warn "PasarGuard CLI Not Found"
fi

if systemctl list-unit-files | grep -qi pasarguard; then
    ok "PasarGuard Service Installed"
else
    warn "PasarGuard Service Not Found"
fi

echo
echo "Installation Completed."

pause
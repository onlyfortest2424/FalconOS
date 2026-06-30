#!/usr/bin/env bash

BASE_DIR="$(cd "$(dirname "$0")/../../.." && pwd)"

source "$BASE_DIR/core/ui.sh"
source "$BASE_DIR/core/functions.sh"
source "$BASE_DIR/panel/pasarguard/functions.sh"

LOG_FILE="/var/log/falconos_pasarguard_install.log"

exec > >(tee -a "$LOG_FILE") 2>&1

title "PasarGuard Panel Installer"

echo "Log File: $LOG_FILE"
echo

# -----------------------------
step=1
total=6

echo "[1/6] Root Check"
require_root
ok "Root Access Verified"

echo "[2/6] OS Check"
check_os
ok "Ubuntu Compatible"

echo "[3/6] Internet Check"
check_internet
ok "Internet Connected"

echo "[4/6] Installing Dependencies"

install_package curl
install_package git
install_package ca-certificates
install_package gnupg

ok "Dependencies Installed"

echo "[5/6] Downloading PasarGuard Panel"

TMP_DIR="/opt/pasarguard"

rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"

git clone https://github.com/PasarGuard/panel "$TMP_DIR"

if [ $? -ne 0 ]; then
    error "Failed to download PasarGuard Panel"
fi

ok "Repository Cloned"

echo "[6/6] Installing Panel"

cd "$TMP_DIR" || error "Directory not found"

if [ -f "install.sh" ]; then
    bash install.sh
else
    error "Installer script not found in repository"
fi

ok "PasarGuard Panel Installed"

echo
echo "====================================================="
echo " INSTALLATION COMPLETED SUCCESSFULLY"
echo "====================================================="
echo
echo "Panel Path : $TMP_DIR"
echo "Log File   : $LOG_FILE"
echo
pause
#!/usr/bin/env bash

BASE_DIR="$(cd "$(dirname "$0")/../../.." && pwd)"

source "$BASE_DIR/core/ui.sh"
source "$BASE_DIR/core/functions.sh"
source "$BASE_DIR/panel/pasarguard/functions.sh"

LOG_FILE="/var/log/falconos_subscription.log"
exec > >(tee -a "$LOG_FILE") 2>&1

title "PasarGuard Subscription Template Installer"

echo "Log File: $LOG_FILE"
echo

echo "[1/5] Root Check"
require_root
ok "Root Access Verified"

echo "[2/5] OS Check"
check_os
ok "Ubuntu Compatible"

echo "[3/5] Internet Check"
check_internet
ok "Internet Connected"

echo "[4/5] Installing Dependencies"
install_package curl
install_package git
install_package unzip
ok "Dependencies Installed"

echo "[5/5] Installing Subscription Template"

SUB_DIR="/opt/pasarguard-subscription"

rm -rf "$SUB_DIR"
mkdir -p "$SUB_DIR"

git clone https://github.com/PasarGuard/subscription-template "$SUB_DIR"

if [ $? -ne 0 ]; then
    error "Failed to clone Subscription Template"
fi

cd "$SUB_DIR" || error "Subscription directory not found"

ok "Subscription Template Installed"

echo
echo "===================================="
echo " SUBSCRIPTION INSTALL COMPLETE"
echo "===================================="

echo "Path: $SUB_DIR"
echo
pause
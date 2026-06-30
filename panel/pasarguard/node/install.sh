#!/usr/bin/env bash

BASE_DIR="$(cd "$(dirname "$0")/../../.." && pwd)"

source "$BASE_DIR/core/ui.sh"
source "$BASE_DIR/core/functions.sh"
source "$BASE_DIR/panel/pasarguard/functions.sh"

LOG_FILE="/var/log/falconos_pasarguard_node.log"
exec > >(tee -a "$LOG_FILE") 2>&1

title "PasarGuard Node Installer"

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
install_package jq
install_package ca-certificates
ok "Dependencies Installed"

echo "[5/5] Installing Node"

NODE_DIR="/opt/pasarguard-node"

rm -rf "$NODE_DIR"
mkdir -p "$NODE_DIR"

git clone https://github.com/PasarGuard/node "$NODE_DIR"

if [ $? -ne 0 ]; then
    error "Failed to clone Node repository"
fi

cd "$NODE_DIR" || error "Node directory not found"

if [ -f "install.sh" ]; then
    bash install.sh
else
    error "Node install script not found"
fi

ok "PasarGuard Node Installed"

echo
echo "===================================="
echo " NODE INSTALLATION COMPLETE"
echo "===================================="

echo "Path: $NODE_DIR"
echo
pause
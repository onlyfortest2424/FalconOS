#!/usr/bin/env bash

# ==========================================
# FalconOS
# Professional Server Toolkit
# Version: 0.1.0-alpha1
# ==========================================

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$BASE_DIR/core/ui.sh"
source "$BASE_DIR/core/functions.sh"
source "$BASE_DIR/core/menu.sh"

main() {
    while true
    do
        clear
        show_banner
        main_menu
    done
}

main
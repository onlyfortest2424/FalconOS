#!/usr/bin/env bash

require_root(){
    [[ $EUID -ne 0 ]] && error "Root required"
}

check_os(){
    [[ ! -f /etc/os-release ]] && error "Linux not supported"

    source /etc/os-release

    case "$VERSION_ID" in
        22.04|24.04) ;;
        *) error "Ubuntu 22.04 / 24.04 required" ;;
    esac
}

check_internet(){
    ping -c1 github.com >/dev/null 2>&1 || error "No internet connection"
}

check_command(){
    command -v "$1" >/dev/null 2>&1
}

install_package(){
    PKG=$1
    if ! check_command "$PKG"; then
        apt update -y
        apt install -y "$PKG"
    fi
}

pause() {

    echo
    echo "----------------------------------------"
    read -rp "Press Enter to return..."
}
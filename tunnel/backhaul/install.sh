#!/usr/bin/env bash

install_backhaul() {

while true; do

    title "Backhaul Installation"

    echo "[1] Install Server (Kharej)"
    echo "[2] Install Client (Iran)"
    echo
    echo "[0] Back"
    echo

    read -rp "Choose: " opt

    case "$opt" in

        1)
            install_backhaul_server
        ;;

        2)
            install_backhaul_client
        ;;

        0)
            return
        ;;

        *)
            warn "Invalid Option"
            sleep 1
        ;;

    esac

done

}

#########################################
# Install Backhaul Server
#########################################

install_backhaul_server() {

    title "Backhaul Server Installation"

    echo "Checking system..."
    echo

    # Root Check
    if [[ $EUID -ne 0 ]]; then
        error "Please run FalconOS as root."
        return
    fi
    ok "Root Access"

    # Detect Architecture
    ARCH=$(uname -m)

    case "$ARCH" in
        x86_64)
            ARCH="amd64"
        ;;
        aarch64)
            ARCH="arm64"
        ;;
        armv7l)
            ARCH="armv7"
        ;;
        *)
            error "Unsupported architecture: $ARCH"
            return
        ;;
    esac

    ok "Architecture : $ARCH"

    # Detect OS
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        OS="$NAME"
    else
        OS="Unknown"
    fi

    ok "Operating System : $OS"

    echo
    echo "System is ready for Backhaul installation."
    echo

    pause

}

#########################################
# Install Backhaul Client
#########################################

install_backhaul_client() {

    title "Backhaul Client Installation"

    warn "Coming Soon"

    pause

}
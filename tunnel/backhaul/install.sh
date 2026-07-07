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

    # Detect Operating System
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        OS="$PRETTY_NAME"
    else
        OS="Unknown"
    fi

    ok "Operating System : $OS"

    # Get Latest Backhaul Release
    get_latest_backhaul_version

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

#########################################
# Get Latest Backhaul Release
#########################################

get_latest_backhaul_version() {

    echo "Checking latest Backhaul release..."
    echo

    BACKHAUL_VERSION=$(curl -fsSL https://api.github.com/repos/Musixal/Backhaul/releases/latest \
        | grep '"tag_name"' \
        | cut -d '"' -f4)

    if [[ -z "$BACKHAUL_VERSION" ]]; then
        error "Failed to get latest Backhaul version."
        return 1
    fi

    ok "Latest Version : $BACKHAUL_VERSION"

}
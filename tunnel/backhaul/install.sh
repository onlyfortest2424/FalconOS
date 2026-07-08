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

download_backhaul
extract_backhaul
install_binary
create_directories

echo
ok "Backhaul installation completed successfully."

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

#########################################
# Download Backhaul
#########################################

download_backhaul() {

    echo
    echo "Downloading Backhaul..."
    echo

    DOWNLOAD_URL="https://github.com/Musixal/Backhaul/releases/download/${BACKHAUL_VERSION}/backhaul_linux_${ARCH}.tar.gz"

    TMP_FILE="/tmp/backhaul_${BACKHAUL_VERSION}_${ARCH}.tar.gz"

    if ! curl -L --progress-bar -o "$TMP_FILE" "$DOWNLOAD_URL"; then
        error "Failed to download Backhaul package."
        return 1
    fi

    ok "Package Downloaded"

}

#########################################
# Extract Backhaul
#########################################

extract_backhaul() {

    echo
    echo "Extracting package..."
    echo

    EXTRACT_DIR="/tmp/backhaul_${BACKHAUL_VERSION}_${ARCH}"

    rm -rf "$EXTRACT_DIR"
    mkdir -p "$EXTRACT_DIR"

    if ! tar -xzf "$TMP_FILE" -C "$EXTRACT_DIR"; then
        error "Failed to extract package."
        return 1
    fi

    ok "Package Extracted"

}

#########################################
# Install Binary
#########################################

install_binary() {

    echo
    echo "Installing Backhaul..."
    echo

    BINARY_FILE=$(find "$EXTRACT_DIR" -type f -name "backhaul" | head -n 1)

    if [[ ! -f "$BINARY_FILE" ]]; then
        error "Backhaul binary not found."
        return 1
    fi

    install -m 755 "$BINARY_FILE" /usr/local/bin/backhaul

    if [[ ! -f /usr/local/bin/backhaul ]]; then
        error "Binary installation failed."
        return 1
    fi

    ok "Binary Installed"

}

#########################################
# Create Backhaul Directories
#########################################

create_directories() {

    echo
    echo "Creating directories..."
    echo

    mkdir -p /etc/backhaul/server
    mkdir -p /etc/backhaul/client
    mkdir -p /etc/backhaul/backup
    mkdir -p /var/log/backhaul

    ok "Directories Created"

}
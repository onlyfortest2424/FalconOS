#!/usr/bin/env bash

#########################################
# PasarGuard Shared Functions
#########################################

require_root() {

    if [[ $EUID -ne 0 ]]; then
        echo
        echo "Please run as root."
        exit 1
    fi

}

#########################################

check_os() {

    if [ ! -f /etc/os-release ]; then
        echo "Unsupported Linux."
        exit 1
    fi

    source /etc/os-release

    case "$VERSION_ID" in

        22.04|24.04)
            ;;

        *)
            echo
            echo "Ubuntu 22.04 or 24.04 required."
            exit 1
            ;;

    esac

}

#########################################

check_internet() {

    ping -c1 github.com >/dev/null 2>&1

    if [ $? -ne 0 ]; then
        echo
        echo "Internet Connection Failed."
        exit 1
    fi

}

#########################################

check_command() {

    command -v "$1" >/dev/null 2>&1

}

#########################################

install_package() {

    PKG=$1

    if ! check_command "$PKG"; then

        apt update
        apt install -y "$PKG"

    fi

}

#########################################

success() {

    echo
    echo "=================================="
    echo "SUCCESS"
    echo "=================================="

}

#########################################

failed() {

    echo
    echo "=================================="
    echo "FAILED"
    echo "=================================="

    exit 1

}
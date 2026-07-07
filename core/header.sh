#!/usr/bin/env bash

#########################################
# FalconOS Header Engine v1.0
#########################################

draw_header() {

    local module="${1:-Main Menu}"

    clear

    echo -e "${CYAN}"
    echo "====================================================="
    echo "                   FalconOS"
    echo "           Professional Server Toolkit"
    echo "====================================================="
    echo -e "${RESET}"

    echo " Module : ${module}"
    echo
}
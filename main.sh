#!/bin/bash

VERSION="0.1.0"

clear

while true
do
    clear

    echo "====================================================="
    echo "                   FalconOS"
    echo "      Professional Server Management Toolkit"
    echo "                 Version $VERSION"
    echo "====================================================="
    echo
    echo " [1] Panel"
    echo " [2] Tunnel"
    echo " [3] Tools"
    echo " [4] Security"
    echo " [5] System"
    echo
    echo " [0] Exit"
    echo
    read -p "Choose: " MENU

    case $MENU in

    1)
        echo
        echo "Panel Module (Coming Soon)"
        read -p "Press Enter..."
        ;;

    2)
        echo
        echo "Tunnel Module (Coming Soon)"
        read -p "Press Enter..."
        ;;

    3)
        echo
        echo "Tools Module (Coming Soon)"
        read -p "Press Enter..."
        ;;

    4)
        echo
        echo "Security Module (Coming Soon)"
        read -p "Press Enter..."
        ;;

    5)
        echo
        echo "System Module (Coming Soon)"
        read -p "Press Enter..."
        ;;

    0)
        clear
        exit
        ;;

    *)
        echo
        echo "Invalid Option"
        sleep 1
        ;;

    esac

done

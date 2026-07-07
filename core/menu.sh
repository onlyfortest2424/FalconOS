#!/usr/bin/env bash

#########################################
# FalconOS Menu Engine v1.0
#########################################

main_menu() {

while true; do

    draw_header "Main Menu"

    echo "[1] Panel"
    echo "[2] Tunnel"
    echo "[3] Tools (Coming Soon)"
    echo "[4] Security (Coming Soon)"
    echo "[5] System (Coming Soon)"
    echo
    echo "[0] Exit"

    draw_footer

    read -rp "Choose: " opt

    case "$opt" in

        1)
            source "$BASE_DIR/panel/pasarguard/menu.sh"
            panel_menu
        ;;

        2)
           source "$BASE_DIR/tunnel/menu.sh"
           tunnel_menu
        ;;

        3)
            # source "$BASE_DIR/tools/menu.sh"
            # tools_menu
            warn "Coming Soon"
            pause
        ;;

        4)
            # source "$BASE_DIR/security/menu.sh"
            # security_menu
            warn "Coming Soon"
            pause
        ;;

        5)
            # source "$BASE_DIR/system/menu.sh"
            # system_menu
            warn "Coming Soon"
            pause
        ;;

        0)
            clear
            exit 0
        ;;

        *)
            warn "Invalid Option"
            sleep 1
        ;;

    esac

done

}
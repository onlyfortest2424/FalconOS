#!/usr/bin/env bash

source "$BASE_DIR/tunnel/backhaul/load.sh"

backhaul_menu() {

while true; do

    draw_header "Backhaul"

    show_backhaul_dashboard

    echo "[1] Install"
    echo "[2] Configure"
    echo "[3] Service"
    echo "[4] Status"
    echo "[5] Backup"
    echo "[6] Update"
    echo "[7] Uninstall"
    echo
    echo "[0] Back"
    echo

    draw_footer

    read -rp "Choose: " opt

    case "$opt" in

        1)
            install_backhaul
        ;;

        2)
            configure_backhaul
        ;;

        3)
            warn "Coming Soon"
            pause
        ;;

        4)
            warn "Coming Soon"
            pause
        ;;

        5)
            warn "Coming Soon"
            pause
        ;;

        6)
            warn "Coming Soon"
            pause
        ;;

        7)
            warn "Coming Soon"
            pause
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
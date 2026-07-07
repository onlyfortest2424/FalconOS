#!/usr/bin/env bash

tunnel_menu() {

while true; do

    draw_header "Tunnel"

    echo "[1] Backhaul"
    echo "[2] WireGuard        (Coming Soon)"
    echo "[3] GOST             (Coming Soon)"
    echo "[4] Hysteria2        (Coming Soon)"
    echo "[5] Sing-box         (Coming Soon)"
    echo "[6] TUIC             (Coming Soon)"
    echo "[7] IPIP             (Coming Soon)"
    echo
    echo "[0] Back"

    draw_footer

    read -rp "Choose: " opt

    case "$opt" in

        1)
            source "$BASE_DIR/tunnel/backhaul/menu.sh"
            backhaul_menu
        ;;

        2|3|4|5|6|7)
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
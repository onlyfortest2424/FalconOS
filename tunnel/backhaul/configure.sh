#!/usr/bin/env bash

configure_backhaul() {

while true; do

    title "Backhaul Configuration"

    echo "[1] Server (Kharej)"
    echo "[2] Client (Iran)"
    echo
    echo "[0] Back"
    echo

    read -rp "Choose: " opt

    case "$opt" in

        1)
            configure_backhaul_server
        ;;

        2)
            configure_backhaul_client
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

configure_backhaul_server() {

    title "Backhaul Server Configuration"

    warn "Coming Soon"

    pause

}

#########################################

configure_backhaul_client() {

    title "Backhaul Client Configuration"

    warn "Coming Soon"

    pause

}
#!/usr/bin/env bash

install_backhaul() {

while true; do

    title "Backhaul Installation"

    echo "[1] Install Server"
    echo "[2] Install Client"
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

install_backhaul_server() {

    title "Backhaul Server Installation"

    warn "Coming Soon"

    pause

}

install_backhaul_client() {

    title "Backhaul Client Installation"

    warn "Coming Soon"

    pause

}
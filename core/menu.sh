#!/usr/bin/env bash

main_menu(){

while true; do

clear
show_banner

echo "[1] Panel"
echo "[2] Tunnel (Coming Soon)"
echo "[3] Tools (Coming Soon)"
echo "[4] Security (Coming Soon)"
echo "[5] System (Coming Soon)"
echo
echo "[0] Exit"
echo

read -rp "Choose: " opt

case $opt in

1)
    source "$BASE_DIR/panel/pasarguard/menu.sh"
    panel_menu
;;

2|3|4|5)
    warn "Coming Soon"
    pause
;;

0)
    exit 0
;;

*)
    warn "Invalid Option"
    sleep 1
;;

esac

done
}
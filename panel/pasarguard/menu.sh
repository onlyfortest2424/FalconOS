#!/usr/bin/env bash

panel_menu() {

while true
do

clear

show_banner

echo "==================== PANEL ===================="
echo
echo " [1] PasarGuard"
echo " [2] Marzban               (Coming Soon)"
echo " [3] 3x-ui                 (Coming Soon)"
echo
echo " [0] Back"
echo

read -rp "Choose: " MENU

case "$MENU" in

1)

    pasarguard_menu

;;

2)

    coming_soon

;;

3)

    coming_soon

;;

0)

    break

;;

*)

    invalid_option

;;

esac

done

}

#################################################

pasarguard_menu() {

while true
do

clear

show_banner

echo "=============== PASARGUARD ==================="
echo
echo " [1] Install Panel"
echo " [2] Install Node"
echo " [3] Install Subscription Template"
echo
echo "----------------------------------------------"
echo
echo " [4] Status"
echo " [5] Backup"
echo " [6] Restore"
echo " [7] Update"
echo " [8] Uninstall"
echo
echo "----------------------------------------------"
echo
echo " [0] Back"
echo

read -rp "Choose: " MENU

case "$MENU" in

1)

    bash "$BASE_DIR/panel/pasarguard/panel/install.sh"

;;

2)

    bash "$BASE_DIR/panel/pasarguard/node/install.sh"

;;

3)

    bash "$BASE_DIR/panel/pasarguard/subscription/install.sh"

;;

4)

    bash "$BASE_DIR/panel/pasarguard/status.sh"

;;

5)

    bash "$BASE_DIR/panel/pasarguard/backup.sh"

;;

6)

    bash "$BASE_DIR/panel/pasarguard/restore.sh"

;;

7)

    bash "$BASE_DIR/panel/pasarguard/update.sh"

;;

8)

    bash "$BASE_DIR/panel/pasarguard/panel/install.sh"

;;

0)

    break

;;

*)

    invalid_option

;;

esac

done

}
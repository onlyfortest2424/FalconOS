#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(realpath "$SCRIPT_DIR/../../..")"

source "$BASE_DIR/core/ui.sh"
source "$BASE_DIR/core/functions.sh"
source "$SCRIPT_DIR/functions.sh"

while true
do
    title "SSL Certificate"

    echo " [1] Issue Panel Certificate"
    echo " [2] Issue Node Certificate"
    echo " [3] Import Existing Certificate"

    echo
    echo "----------------------------------------"
    echo
    echo " [0] Back"
    echo

    read -rp "Select an option: " OPTION

    case "$OPTION" in
        1) bash "$SCRIPT_DIR/issue-panel.sh" ;;
        2) bash "$SCRIPT_DIR/issue-node.sh" ;;
        3) bash "$SCRIPT_DIR/import.sh" ;;
        0) exit ;;
        *) invalid ;;
    esac
done
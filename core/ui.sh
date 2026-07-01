#!/usr/bin/env bash

#########################################
# FalconOS UI Engine v0.2
#########################################

RESET='\033[0m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'

STEP=0
TOTAL=6

clear_screen(){
    clear
}

show_banner(){

echo -e "${CYAN}"
echo "====================================================="
echo "                   FalconOS"
echo "           Professional Server Toolkit"
echo "====================================================="
echo -e "${RESET}"
}

title(){
    clear_screen
    show_banner
    echo "-----------------------------------------------------"
    echo " $1"
    echo "-----------------------------------------------------"
    echo
}

pause() {

    echo
    echo "----------------------------------------"
    read -rp "Press Enter to return..."
}

progress_bar(){

STEP=$((STEP+1))
PERCENT=$((STEP*100/TOTAL))
FILLED=$((PERCENT/10))

BAR=""
for ((i=1;i<=10;i++)); do
    if [ $i -le $FILLED ]; then
        BAR="${BAR}█"
    else
        BAR="${BAR}░"
    fi
done

echo -e "${YELLOW}[$BAR] ${PERCENT}%${RESET}"
echo
}

ok(){
    progress_bar
    echo -e "${GREEN}✔ $1${RESET}"
    sleep 0.5
}

warn(){
    echo -e "${YELLOW}⚠ $1${RESET}"
}

error(){
    echo -e "${RED}✘ $1${RESET}"
    exit 1
}

loading(){
    echo
    echo "Please wait..."
    sleep 0.7
}
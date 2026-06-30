#!/usr/bin/env bash

show_banner() {

HOST=$(hostname)

OS=$(grep PRETTY_NAME /etc/os-release 2>/dev/null | cut -d '"' -f2)

KERNEL=$(uname -r)

ARCH=$(uname -m)

CPU=$(nproc)

RAM=$(free -h | awk '/Mem:/ {print $3 " / " $2}')

DISK=$(df -h / | awk 'NR==2 {print $3 " / " $2}')

UPTIME=$(uptime -p | sed 's/up //')

IP=$(hostname -I | awk '{print $1}')

echo -e "${CYAN}"

echo "============================================================"
echo "                     FalconOS"
echo "          Professional Server Toolkit"
echo "                  v0.1.0-alpha1"
echo "============================================================"

echo -e "${WHITE}Host     : ${GREEN}$HOST"
echo -e "${WHITE}OS       : ${GREEN}$OS"
echo -e "${WHITE}Kernel   : ${GREEN}$KERNEL"
echo -e "${WHITE}CPU      : ${GREEN}$CPU Cores"
echo -e "${WHITE}Arch     : ${GREEN}$ARCH"
echo -e "${WHITE}RAM      : ${GREEN}$RAM"
echo -e "${WHITE}Disk     : ${GREEN}$DISK"
echo -e "${WHITE}Uptime   : ${GREEN}$UPTIME"
echo -e "${WHITE}IPv4     : ${GREEN}$IP"

echo -e "${CYAN}============================================================${RESET}"

echo

}
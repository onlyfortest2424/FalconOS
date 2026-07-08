#!/usr/bin/env bash

show_backhaul_dashboard() {

    if command -v backhaul >/dev/null 2>&1; then
        STATUS="${GREEN}🟢 Installed${RESET}"
    else
        STATUS="${RED}🔴 Not Installed${RESET}"
    fi

    if [[ -f /etc/backhaul/server.toml || -f /etc/backhaul/client.toml ]]; then
        CONFIG="${GREEN}🟢 OK${RESET}"
    else
        CONFIG="${RED}🔴 Missing${RESET}"
    fi

    if systemctl is-active --quiet backhaul-server 2>/dev/null || \
       systemctl is-active --quiet backhaul-client 2>/dev/null; then
        SERVICE="${GREEN}🟢 Running${RESET}"
    else
        SERVICE="${RED}🔴 Stopped${RESET}"
    fi

    echo -e " Status  : $STATUS"
    echo -e " Config  : $CONFIG"
    echo -e " Service : $SERVICE"
    echo
}
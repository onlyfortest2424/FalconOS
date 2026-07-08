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

    echo "Transport"
    echo
    echo "[1] TCP"
    echo "[2] WebSocket"
    echo "[3] TCP + TLS"
    echo "[4] gRPC"
    echo
    echo "[0] Back"
    echo

    read -rp "Choose: " transport

    case "$transport" in

        1)
            TRANSPORT="tcp"
        ;;

        2)
            TRANSPORT="ws"
        ;;

        3)
            TRANSPORT="tcp"
        ;;

        4)
            TRANSPORT="grpc"
        ;;

        0)
            return
        ;;

        *)
            warn "Invalid Option"
            pause
            return
        ;;

    esac

    ask_server_port

}

#########################################

ask_server_port() {

    title "Backhaul Server Configuration"

    echo "Transport : $TRANSPORT"
    echo

    read -rp "Listen Port : " SERVER_PORT

    ask_server_token

}

#########################################

ask_server_token() {

    title "Backhaul Server Configuration"

    echo "Transport : $TRANSPORT"
    echo "Port      : $SERVER_PORT"
    echo

    read -rp "Token : " TOKEN

    ask_server_mapping

}

#########################################

ask_server_mapping() {

    title "Backhaul Server Configuration"

    echo "Example"
    echo
    echo "443=127.0.0.1:443"
    echo

    read -rp "Port Mapping : " PORTS

    echo
    ok "Wizard completed."

    echo
    echo "Transport : $TRANSPORT"
    echo "Port      : $SERVER_PORT"
    echo "Token     : $TOKEN"
    echo "Mapping   : $PORTS"

    pause

}

#########################################

configure_backhaul_client() {

    title "Backhaul Client Configuration"

    warn "Coming Soon"

    pause

}
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

    ask_required "Listen Port"
    SERVER_PORT="$REPLY"

    ask_server_token

}

#########################################

ask_server_token() {

    title "Backhaul Server Configuration"

    echo "Transport : $TRANSPORT"
    echo "Port      : $SERVER_PORT"
    echo

    ask_required "Token"
    TOKEN="$REPLY"

    ask_server_mapping

}

#########################################

ask_server_mapping() {

    title "Backhaul Server Configuration"

    echo "Port Mapping"
    echo
    echo "Format:"
    echo
    echo "ExternalPort=DestinationIP:DestinationPort"
    echo
    echo "Example:"
    echo
    echo "443=127.0.0.1:443"
    echo

    ask_required "Port Mapping"
    PORTS="$REPLY"

    review_server_configuration

}

#########################################

configure_backhaul_client() {

    title "Backhaul Client Configuration"

    warn "Coming Soon"

    pause

}

#########################################

review_server_configuration() {

while true; do

    title "Review Configuration"

    echo "========================================"
    echo
    echo " Transport : $TRANSPORT"
    echo " Port      : $SERVER_PORT"
    echo " Token     : ********"
    echo " Mapping   : $PORTS"
    echo
    echo "========================================"
    echo
    echo "[1] Save"
    echo "[2] Edit"
    echo
    echo "[0] Cancel"
    echo

    read -rp "Choose: " opt

    case "$opt" in

        1)
            ok "Configuration saved."
            pause
            return
        ;;

        2)
            edit_server_configuration
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

edit_server_configuration() {

while true; do

    title "Edit Configuration"

    echo "[1] Transport"
    echo "[2] Listen Port"
    echo "[3] Token"
    echo "[4] Port Mapping"
    echo
    echo "[0] Back"
    echo

    read -rp "Choose: " edit

    case "$edit" in

        1)
            configure_backhaul_server
            return
        ;;

        2)
            ask_server_port
            return
        ;;

        3)
            ask_server_token
            return
        ;;

        4)
            ask_server_mapping
            return
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
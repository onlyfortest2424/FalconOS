#!/usr/bin/env bash

#########################################
# Backhaul Configuration
#########################################

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
            server_wizard
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
# Server Wizard
#########################################

server_wizard() {

    ask_transport
    ask_server_port
    ask_server_token
    ask_server_mapping

    review_server_configuration

}

#########################################
# Transport
#########################################

ask_transport() {

while true; do

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
            return
        ;;

        2)
            TRANSPORT="ws"
            return
        ;;

        3)
            TRANSPORT="tcp+tls"
            return
        ;;

        4)
            TRANSPORT="grpc"
            return
        ;;

        0)
            return 1
        ;;

        *)
            warn "Invalid Option"
            sleep 1
        ;;

    esac

done

}

#########################################
# Listen Port
#########################################

ask_server_port() {

    title "Backhaul Server Configuration"

    echo "Transport : $TRANSPORT"
    echo
    echo "Backhaul Server Listen Port"
    echo
    echo "Range : 1 - 65535"
    echo

    ask_required "Listen Port"

    SERVER_PORT="$REPLY"

}

#########################################
# Token
#########################################

ask_server_token() {

    title "Backhaul Server Configuration"

    echo "Transport : $TRANSPORT"
    echo "Port      : $SERVER_PORT"
    echo
    echo "Authentication Token"
    echo
    echo "English letters and numbers only."
    echo

    ask_required "Token"

    TOKEN="$REPLY"

}

#########################################
# Port Mapping
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

}

#########################################
# Review
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

        generate_server_config

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
# Edit
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
            edit_transport
            return
        ;;

        2)
            edit_port
            return
        ;;

        3)
            edit_token
            return
        ;;

        4)
            edit_mapping
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

#########################################
# Edit Transport
#########################################

edit_transport() {

    ask_transport

    review_server_configuration

}

#########################################
# Edit Port
#########################################

edit_port() {

    ask_server_port

    review_server_configuration

}

#########################################
# Edit Token
#########################################

edit_token() {

    ask_server_token

    review_server_configuration

}

#########################################
# Edit Mapping
#########################################

edit_mapping() {

    ask_server_mapping

    review_server_configuration

}

#########################################
# Client
#########################################

configure_backhaul_client() {

    title "Backhaul Client Configuration"

    warn "Coming Soon"

    pause

}
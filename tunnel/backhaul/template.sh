#!/usr/bin/env bash

#########################################
# Backhaul Template Engine
#########################################

generate_server_config() {

    echo "Template Engine Started"

    mkdir -p /etc/backhaul/server

    cp "$BASE_DIR/templates/backhaul/server.toml" \
       /etc/backhaul/server/server.toml

    sed -i "s|{{TRANSPORT}}|$TRANSPORT|g" \
        /etc/backhaul/server/server.toml

    sed -i "s|{{BIND_PORT}}|$SERVER_PORT|g" \
        /etc/backhaul/server/server.toml

    sed -i "s|{{TOKEN}}|$TOKEN|g" \
        /etc/backhaul/server/server.toml

    sed -i "s|{{PORTS}}|$PORTS|g" \
        /etc/backhaul/server/server.toml

}
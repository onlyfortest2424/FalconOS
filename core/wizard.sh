#!/usr/bin/env bash

#########################################
# FalconOS Wizard Engine
#########################################

ask_required() {

    local LABEL="$1"
    local RESULT

    while true; do

        read -rp "$LABEL : " RESULT

        if [[ -n "$RESULT" ]]; then
            REPLY="$RESULT"
            return
        fi

        warn "$LABEL cannot be empty."

    done

}
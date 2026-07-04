#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(realpath "$SCRIPT_DIR/../..")"

source "$BASE_DIR/core/ui.sh"
source "$BASE_DIR/core/functions.sh"

title "Create Owner Account"

echo "Generating temporary setup key..."
echo

docker exec -it pasarguard-pasarguard-1 \
    pasarguard cli generate-temp-key

echo
echo "----------------------------------------"
echo "The temporary setup key is valid for 5 minutes"
echo "and can only be used once."
echo
echo "Generate a new key if it expires."
echo "----------------------------------------"

pause
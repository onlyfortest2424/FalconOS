#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(realpath "$SCRIPT_DIR/../..")"

source "$BASE_DIR/core/ui.sh"
source "$BASE_DIR/core/functions.sh"

title "Create Owner Account"

echo "Checking PasarGuard status..."
echo

if ! docker ps --format '{{.Names}}' | grep -q '^pasarguard-pasarguard-1$'; then
    echo "✗ PasarGuard panel is not running."
    echo
    echo "Please install or start the panel first."
    echo
    pause
    exit 1
fi

echo "✓ PasarGuard is running."
echo

echo "Generating temporary setup key..."
echo

docker exec -it pasarguard-pasarguard-1 \
    pasarguard-cli generate-temp-key

if [ $? -ne 0 ]; then
    echo
    echo "✗ Failed to generate setup key."
    echo
    pause
    exit 1
fi

echo
echo "----------------------------------------"
echo "The temporary setup key is valid for 5 minutes"
echo "and can only be used once."
echo
echo "Generate a new key if it expires."
echo "----------------------------------------"

pause
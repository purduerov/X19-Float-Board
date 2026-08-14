#!/usr/bin/env bash
set -e

# Delegate hardware validation to central pcb-devops repository
CACHE_DIR=".pcb-devops-cache"

if [ ! -d "$CACHE_DIR" ]; then
    echo "Fetching central pcb-devops tooling..."
    git clone --depth 1 https://github.com/purduerov/pcb-devops.git "$CACHE_DIR"
else
    echo "Updating central pcb-devops tooling..."
    git -C "$CACHE_DIR" pull origin master --quiet
fi

if [ -d "libs" ]; then
    find libs -name "*.kicad_sym" -exec python3 "$CACHE_DIR/scripts/linter_validator.py" {} +
else
    echo "No local symbol libraries found in libs/."
fi

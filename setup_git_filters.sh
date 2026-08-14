#!/usr/bin/env bash
set -e

CACHE_DIR=".pcb-devops-cache"

if [ ! -d "$CACHE_DIR" ]; then
    echo "Fetching central pcb-devops tooling..."
    git clone --depth 1 https://github.com/purduerov/pcb-devops.git "$CACHE_DIR"
fi

bash "$CACHE_DIR/scripts/setup_git_filters.sh"

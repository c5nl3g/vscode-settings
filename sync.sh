#!/bin/bash
set -euo pipefail

cp_settings() {
    cp /mnt/c/Users/cillian/AppData/Roaming/Code/User/settings.json .vscode/settings.json
    echo ".vscode/settings.json updated"
}

cp_extensions() {
    code --list-extensions |
        grep -v "^Extensions installed" |
        jq -R -s 'split("\n") | map(select(. != "")) | {recommendations: .}' \
            >.vscode/extensions.json
    echo ".vscode/extensions.json updated"
}

sync() {
    mkdir -p .vscode
    cp_settings
    cp_extensions
}

usage() {
    cat <<EOF
Usage: $0 <command>

Commands:
  all           Copy settings and export extensions
  settings      Copy vscode settings.json only
  extensions    Export extensions.json only
EOF
}

case "${1:-}" in
all) sync ;;
settings)
    mkdir -p .vscode
    cp_settings
    ;;
extensions)
    mkdir -p .vscode
    cp_extensions
    ;;
*) usage ;;
esac

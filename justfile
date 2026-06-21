_default:
    just --list

@_cp-settings:
    cp /mnt/c/Users/cillian/AppData/Roaming/Code/User/settings.json .vscode/settings.json
    echo ".vscode/settings.json updated"

@_cp-extensions:
    code --list-extensions | grep -v "^Extensions installed" | jq -R -s 'split("\n") | map(select(. != "")) | {recommendations: .}' > .vscode/extensions.json
    echo ".vscode/extensions.json updated"

sync: _cp-settings _cp-extensions

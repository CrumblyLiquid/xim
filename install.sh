#!/usr/bin/env sh

URL="https://github.com/CrumblyLiquid/xim"
XOURNALPP_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/xournalpp"

git clone --depth 1 "$URL" "$XOURNALPP_CONFIG/plugins/xim"

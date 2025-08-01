#!/usr/bin/env bash

# STATE_FILE="$HOME/.cache/.tlp_mode"
STATE_FILE="/tmp/.tlp_mode"

if [[ ! -f "$STATE_FILE" ]]; then
    echo "auto" > "$STATE_FILE"
fi

CURRENT=$(<"$STATE_FILE")

# Module click logic
if [[ "$1" == "click" ]]; then
    case "$CURRENT" in
        auto)
            sudo tlp bat >/dev/null
            echo "bat" > "$STATE_FILE"
            ;;
        bat)
            sudo tlp ac >/dev/null
            echo "ac" > "$STATE_FILE"
            ;;
        ac)
            sudo tlp start >/dev/null
            echo "auto" > "$STATE_FILE"
            ;;
    esac
    # Trigger Waybar to update this module immediately
    pkill -RTMIN+5 waybar # The ID of this module is 5, thus "signal" in the config has to be = 5
    exit 0
fi

# Output current mode for Waybar
case "$CURRENT" in
    bat)
        echo " BAT"
        ;;
    ac)
        echo "  AC"
        ;;
    auto)
        echo "AUTO"
        ;;
esac
exit 0

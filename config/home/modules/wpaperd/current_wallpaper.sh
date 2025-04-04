#!/bin/sh 

# !!!!!!!!
# https://github.com/danyspin97/wpaperd?tab=readme-ov-file#wallpaper-link
# https://github.com/danyspin97/wpaperd?tab=readme-ov-file#exec-script



# This script retrieves the current wallpaper for each monitor using wpaperctl
# wpaperctl all-wallpapers
# >> eDP-1: /home/dreezy/.config/wallpapers/village.jpg


# Get all wallpapers and store them in an associative array
declare -A wallpapers

while IFS=":" read -r monitor path; do
    monitor=$(echo "$monitor" | xargs)
    path=$(echo "$path" | xargs)
    wallpapers["$monitor"]="$path"
done < <(wpaperctl all-wallpapers)

# Access example:
echo "Wallpaper for eDP-1 is: ${wallpapers["eDP-1"]}"

# For loop example:
for monitor in "${!wallpapers[@]}"; do
    wallpaper="${wallpapers[$monitor]}"
    echo "Monitor: $monitor"
    echo "Wallpaper: $wallpaper"
    echo "------"
done
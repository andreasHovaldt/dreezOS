#!/bin/sh

#!/bin/bash

#!/usr/bin/env bash

display=$1
wallpaper=$2
logfile="/home/dreezy/.config/wpaperd/current_wallpaper.log"

echo "Display is : $display"
echo "Wallpaper path is: $wallpaper"

# Update current wallpaper link
echo ":: Linking current_wallpaper with $wallpaper" >> "$logfile"
ln -sf "$wallpaper" "/home/dreezy/.config/wpaperd/current_wallpaper"
{pkgs, ...}:
pkgs.writeShellScript "randomWallpaperScript" ''
  #!/usr/bin/bash bash

  directory=~/Pictures/Wallpaper
  monitor=$(hyprctl monitors | grep Monitor | awk 'NR==1{print $2}')

  if [ -d "$directory" ]; then
  	random_background=$(ls $directory/ | shuf -n 1)
  	echo $random_background

  	hyprctl hyprpaper unload all
  	hyprctl hyprpaper preload "$directory/$random_background"
  	hyprctl hyprpaper wallpaper "$monitor, $directory/$random_background"
  	hyprctl hyprpaper wallpaper "eDP-1, $directory/$random_background"
  fi
''

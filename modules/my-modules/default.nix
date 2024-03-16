{pkgs, ...}:
pkgs.writeShellScript "randomWallpaperScript" ''
  #!/usr/bin/bash bash

  directory=~/Pictures/Wallpaper
  monitor=$(hyprctl monitors | grep Monitor | awk 'NR==1{print $2}')
  mapfile -t monitors < <(hyprctl monitors | grep Monitor | awk '{print $2}')

  if [ -d "$directory" ]; then
  	random_background=$(ls $directory/ | shuf -n 1)
  	hyprctl hyprpaper unload all
  	hyprctl hyprpaper preload "$directory/$random_background"
    for monitor in "''${monitors[@]}"; do
  	  hyprctl hyprpaper wallpaper "$monitor, $directory/$random_background"
    done

  fi
''

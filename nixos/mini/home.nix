{ config, pkgs,lib, ... }:
let
default = import ../share/home-manager/default.nix;
waybarConfig = import ./waybar.nix;
hyprlandConfig = import ./hyprland.nix;
in
{
  wayland.windowManager.hyprland = hyprlandConfig pkgs;  
  programs = lib.mkMerge [
    (default pkgs)
    { 
      wofi.enable = true;
      waybar = waybarConfig pkgs;
    }
  ];
  home.username = "denis";
  home.homeDirectory = "/home/denis";

  home.stateVersion = "23.05";

  xdg.enable = true;

  qt.enable = true;
  qt.platformTheme = "gtk";
  qt.style.name = "Dracula";
  #qt.style.package = pkgs.dracula-theme;

  gtk.enable = true;
  gtk.cursorTheme.package = pkgs.bibata-cursors;
  gtk.cursorTheme.name = "Dracula-cursors";
  gtk.theme.package = pkgs.dracula-theme;
  gtk.theme.name = "Dracula";
  gtk.iconTheme.package = pkgs.dracula-icon-theme;
  gtk.iconTheme.name = "Dracula";
#why is home.sessionVariables not working????
## ==> sessionvariables set in hyprland config
  fonts.fontconfig.enable = true;
}

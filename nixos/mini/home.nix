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
      wofi.style = ''
      * {
          all: unset;
          font-family: "JetBrainsMono";
          font-size: 16px;
      }

      #window {
          background-color: #292a37;
          border-radius: 12px;
      }

      #outer-box {
          background-color: #292a37;
          border: 4px solid #44465c;
          border-radius: 12px;
      }

      #input{
          margin: 1rem;
          padding: 0.5rem;
          border-radius: 10px;
          background-color: #303241;
      }

      #entry {
          margin: 0.25rem 0.75rem 0.25rem 0.75rem;
          padding: 0.25rem 0.75rem 0.25rem 0.75rem;
          color: #9699b7;
          border-radius: 3px;
      }

      #entry:selected {
          background-color: #303241;
          color: #d9e0ee;
      }
      '';
      rofi.enable = true;
      rofi.theme = "rofi-dracula";
      waybar = waybarConfig pkgs;
    }
  ];

  services.dunst = {
            enable = true;
            settings = {
                global = {
                    origin = "top-left";
                    offset = "60x12";
                    separator_height = 2;
                    padding = 12;
                    horizontal_padding = 12;
                    text_icon_padding = 12;
                    frame_width = 4;
                    separator_color = "frame";
                    idle_threshold = 120;
                    font = "JetBrainsMono Nerdfont 12";
                    line_height = 0;
                    format = "<b>%s</b>\n%b";
                    alignment = "center";
                    icon_position = "off";
                    startup_notification = "false";
                    corner_radius = 12;

                    frame_color = "#44465c";
                    background = "#303241";
                    foreground = "#d9e0ee";
                    timeout = 2;
                };
            };
        };
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

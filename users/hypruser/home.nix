{ config, pkgs, lib, inputs, ... }:
let
  waybarConfig = import ./waybar.nix;
  hyprlandConfig = import ./hyprland.nix;
  my_packages = import ../denis/packages.nix { inherit pkgs config; };
in
{
  wayland.windowManager.hyprland = hyprlandConfig pkgs;
  programs = lib.mkMerge [
    (import ../../modules/home-manager/alacritty.nix { inherit config pkgs; })
    (import ../../modules/home-manager/bash.nix { inherit config pkgs; })
    (import ../../modules/home-manager/eza.nix { inherit config pkgs; })
    (import ../../modules/home-manager/git.nix { inherit config pkgs; })
    (import ../../modules/home-manager/firefox.nix { inherit config inputs pkgs; })
    (import ../../modules/home-manager/man.nix { inherit config pkgs; })
    (import ../../modules/home-manager/nix-index.nix { inherit config pkgs; })
    (import ../../modules/home-manager/oh-my-posh.nix { inherit config pkgs; })
    (import ../../modules/home-manager/tealdeer.nix { inherit config pkgs; })
    (import ../../modules/home-manager/wofi.nix { inherit config pkgs lib; })
    (import ../../modules/home-manager/bash.nix { inherit config pkgs; })
    (import ../../modules/home-manager/neovim { inherit config pkgs lib; })
    {
      rofi.enable = true;
      rofi.theme = "rofi-dracula";
      ripgrep.enable = true;
      htop.enable = true;
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
  home.username = "hypruser";
  home.homeDirectory = "/home/hypruser";

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

  home.packages = lib.mkMerge [
    my_packages.user_packages
    my_packages.commandline_tools
  ];
}

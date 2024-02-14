{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  my_packages = import ../denis/packages.nix {inherit pkgs config;};
in {
  imports = [inputs.hyprland.homeManagerModules.default];
  home = {
    username = "hypruser";
    homeDirectory = "/home/hypruser";
    packages = lib.mkMerge [
      my_packages.user_packages
      my_packages.commandline_tools
    ];

    stateVersion = "23.05";
  };

  #wayland.windowManager = import ../../modules/home-manager/hyprland/hyprland.nix {inherit config pkgs;};

  programs = let
    mods = ["waybar" "kitty" "alacritty" "bash" "eza" "firefox" "fzf" "git" "man" "nix-index" "oh-my-posh" "tealdeer"];
  in
    lib.mkMerge
    ((lib.forEach mods (x: (import ../../modules/home-manager/${x}.nix {inherit config pkgs inputs lib;})))
      ++ [
        {
          rofi.enable = true;
          rofi.theme = "rofi-dracula";
          ripgrep.enable = true;
          htop.enable = true;
          mpv.enable = true;
        }
      ]);

  # use some other notification thingy for wayland
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

  xdg.enable = true;

  gtk = {
    enable = true;
    cursorTheme.package = pkgs.bibata-cursors;
    cursorTheme.name = "Dracula-cursors";
    theme.package = pkgs.dracula-theme;
    theme.name = "Dracula";
    iconTheme.package = pkgs.dracula-icon-theme;
    iconTheme.name = "Dracula";
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style.name = "Dracula";
    #qt.style.package = pkgs.dracula-theme;
  };

  #why is home.sessionVariables not working????
  ## ==> sessionvariables set in hyprland config
  fonts.fontconfig.enable = true;
}

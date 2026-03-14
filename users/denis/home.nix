{
  config,
  hostName,
  inputs,
  lib,
  pkgs,
  ...
}: let
  my_packages = import ./packages.nix {inherit pkgs config;};
in {
  imports = [
    inputs.nvf.homeManagerModules.default
  ];
  home = {
    username = "denis";
    homeDirectory = "/home/denis";
    packages = lib.mkMerge [
      my_packages.kde_packages
      my_packages.user_packages
      my_packages.commandline_tools
    ];

    stateVersion = "23.05";
  };

  services = {
    mako = {
      enable = false;
    };
    polkit-gnome = {
      enable = true;
    };
    swayidle = {
      enable = false;
    };
    playerctld.enable = false;
  };

  wayland.windowManager = import ../../modules/home-manager/hyprland/hyprland.nix {
    inherit config pkgs inputs hostName;
  };

  programs = let
    mods = [
      "alacritty"
      "bash"
      "eza"
      "firefox"
      "foot"
      "fzf"
      "git"
      "man"
      "mpv"
      "nix-index"
      "nvim"
      "oh-my-posh"
      "tealdeer"
      "tmux"
      "vscode"
      "wofi"
      "yazi"
    ];
  in
    lib.mkMerge
    ((lib.forEach mods
        (x: (import ../../modules/home-manager/${x}.nix {inherit config pkgs inputs lib;})))
      ++ [
        {
          direnv = {
            enable = true;
            enableBashIntegration = true;
            nix-direnv.enable = true;
          };
          ripgrep.enable = true;
          bat.enable = true;
          yt-dlp.enable = true;
          eww = {
            enable = true;
            configDir = config.lib.file.mkOutOfStoreSymlink ./eww;
          };
          fuzzel = {
            enable = true;
          };
          swaylock = {enable = true;};
          waybar = {
            enable = true;
          };
        }
      ]);
  home.file.".config/hypr/hyprpaper.conf".text = ''
  '';
  xdg = {
    userDirs = {
      enable = true;
      documents = "${config.home.homeDirectory}/Nextcloud/Documents";
      pictures = "${config.home.homeDirectory}/Nextcloud/Media/Pictures";
      videos = "${config.home.homeDirectory}/Nextcloud/Media/Videos";
      download = "${config.home.homeDirectory}/Downloads";
      desktop = "${config.home.homeDirectory}/Desktop";
      templates = "${config.home.homeDirectory}/Templates";
      extraConfig = {
        XDG_REPOS_DIR = "${config.home.homeDirectory}/repos";
      };
    };
    configFile."niri/config.kdl".source = ./config.kdl;
  };
}

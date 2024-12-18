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
  #imports = [inputs.hyprland.homeManagerModules.default];
  home = {
    username = "denis";
    homeDirectory = "/home/denis";
    packages = lib.mkMerge [
      (lib.mkIf (hostName == "epimetheus") [inputs.nix-gaming.packages.x86_64-linux.star-citizen])
      my_packages.kde_packages
      my_packages.user_packages
      my_packages.commandline_tools
    ];

    stateVersion = "23.05";
  };

  # services.mako.enable = true;

  services.playerctld.enable = true;
  wayland.windowManager = import ../../modules/home-manager/hyprland/hyprland.nix {
    inherit config pkgs inputs hostName;
  };

  programs = let
    # todo: only import vscode if hostname is epimetheus or try vscode on asus first
    mods = [
      "bash"
      "eza"
      "firefox"
      "fzf"
      "git"
      "man"
      "nix-index"
      "oh-my-posh"
      "tealdeer"
      "vscode"
      "wofi"
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
          htop.enable = true;
          mpv.enable = true;
          mpv.scripts = with pkgs; [
            mpvScripts.mpris
            mpvScripts.autoload
          ];
          ranger = {
            enable = true;
            extraConfig = ''
              set preview_images true
              set preview_images_method sixel
            '';
          };
          ripgrep.enable = true;
          bat.enable = true;
          foot = {
            enable = true;
            server.enable = true;
            settings = {
              main = {
                font = "DeJaVuSansM Nerd Font Mono:size=14";
              };
              colors = {
                alpha = "0.9";
                foreground = "f8f8f2";
                background = "282a36";
                regular0 = "000000";
                regular1 = "ff5555";
                regular2 = "50fa7b";
                regular3 = "f1fa8c";
                regular4 = "bd93f9";
                regular5 = "ff79c6";
                regular6 = "8be9fd";
                regular7 = "bfbfbf";
                bright0 = "4d4d4d";
                bright1 = "ff6e67";
                bright2 = "5af78e";
                bright3 = "f4f99d";
                bright4 = "caa9fa";
                bright5 = "ff92d0";
                bright6 = "9aedfe";
                bright7 = "e6e6e6";
              };
            };
          };
          tmux = {
            enable = true;
            mouse = true;
            # newSession = true;
            plugins = with pkgs.tmuxPlugins; [
              {
                plugin = power-theme;
                extraConfig = ''
                  set -g @tmux_power_theme 'gold'
                '';
              }
              yank
              vim-tmux-navigator
            ];
            extraConfig = ''
              set -g status-position top
              unbind C-b
              set -g prefix C-a

              set -g mode-keys vi
              bind-key h select-pane -L
              bind-key j select-pane -D
              bind-key k select-pane -U
              bind-key l select-pane -R

              bind-key -T copy-mode-vi v send-keys -X begin-selection
              bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
              bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
            '';
          };
          yt-dlp.enable = true; #to play some music with mpv
          yazi = {
            enable = true;
            enableBashIntegration = true;
            settings = {
              manager = {
                sort_by = "alphabetical";
                sort_dir_first = true;
                show_hidden = true;
                sort_sensitive = false;
              };
            };
          };
          eww = {
            enable = true;
            configDir = config.lib.file.mkOutOfStoreSymlink ./eww;
          };
        }
      ]);
  home.file.".config/hypr/hyprpaper.conf".text = ''
  '';
}

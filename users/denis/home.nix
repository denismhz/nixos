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
  home = {
    username = "denis";
    homeDirectory = "/home/denis";
    packages = lib.mkMerge [
      (lib.mkIf (hostName == "epimetheus") my_packages.kde_packages)
      (lib.mkIf (hostName == "epimetheus") [inputs.nix-gaming.packages.x86_64-linux.star-citizen])
      my_packages.user_packages
      my_packages.commandline_tools
    ];

    stateVersion = "23.05";
  };
  wayland.windowManager.hyprland = import ../../modules/home-manager/hyprland {};

  programs = let
    # todo: only import vscode if hostname is epimetheus or try vscode on asus first
    mods = ["kitty" "alacritty" "bash" "eza" "firefox" "fzf" "git" "man" "nix-index" "oh-my-posh" "tealdeer" "vscode"];
  in
    lib.mkMerge
    ((lib.forEach mods (x: (import ../../modules/home-manager/${x}.nix {inherit config pkgs inputs lib;})))
      ++ [
        {
          bat.enable = true;
          direnv = {
            enable = true;
            enableBashIntegration = true;
            nix-direnv.enable = true;
          };
          htop.enable = true;
          mpv.enable = true;
          ripgrep.enable = true;
          tmux.enable = true;
          yt-dlp.enable = true; #to play some music with mpv
          yazi = {
            enable = true;
            enableBashIntegration = true;
          };
        }
      ]);
}

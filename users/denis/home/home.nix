{ config, pkgs, lib, inputs, ... }:
let
in
{
  home.username = "denis";
  home.homeDirectory = "/home/denis";
  programs = lib.mkMerge [
    (import ./programs/vscode.nix { inherit config pkgs; })
    (import ../../../modules/home-manager/alacritty.nix { inherit config pkgs; })
    (import ../../../modules/home-manager/bash.nix { inherit config pkgs; })
    (import ../../../modules/home-manager/eza.nix { inherit config pkgs; })
    (import ../../../modules/home-manager/firefox.nix { inherit config inputs pkgs lib; })
    (import ../../../modules/home-manager/git.nix { inherit config pkgs; })
    (import ../../../modules/home-manager/man.nix { inherit config pkgs; })
    (import ../../../modules/home-manager/nix-index.nix { inherit config pkgs; })
    (import ../../../modules/home-manager/oh-my-posh.nix { inherit config pkgs; })
    (import ../../../modules/home-manager/tealdeer.nix { inherit config pkgs; })
    (import ../../../modules/home-manager/bash.nix { inherit config pkgs; })
    (import ../../../modules/home-manager/neovim { inherit config pkgs lib; })
    (import ../../../modules/home-manager/fzf.nix { inherit config pkgs; })
    {
      ripgrep.enable = true;
      tmux.enable = true;
      bat.enable = true;
      htop.enable = true;
    }
  ];

  home.packages = (import ../packages.nix { inherit pkgs config; }).user_packages;

  home.stateVersion = "23.05";
}

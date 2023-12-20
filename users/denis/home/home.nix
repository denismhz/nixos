{ config, pkgs, lib, inputs, ... }:
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
    {
      ripgrep.enable = true;
      rbw.enable = true;
      tmux.enable = true;
    }
  ];
/*   services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  }; */

  home.stateVersion = "23.05";
}

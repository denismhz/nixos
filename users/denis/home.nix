{ config, pkgs, lib, inputs, hostName, ... }:
let
  my_packages = import ./packages.nix { inherit pkgs config; };
in
{
  home.username = "denis";
  home.homeDirectory = "/home/denis";
  programs = lib.mkMerge [
    (import ../../modules/home-manager/vscode.nix { inherit config pkgs; })
    (import ../../modules/home-manager/alacritty.nix { inherit config pkgs; })
    (import ../../modules/home-manager/bash.nix { inherit config pkgs; })
    (import ../../modules/home-manager/eza.nix { inherit config pkgs; })
    (import ../../modules/home-manager/firefox.nix { inherit config inputs pkgs lib; })
    (import ../../modules/home-manager/git.nix { inherit config pkgs; })
    (import ../../modules/home-manager/man.nix { inherit config pkgs; })
    (import ../../modules/home-manager/nix-index.nix { inherit config pkgs; })
    (import ../../modules/home-manager/oh-my-posh.nix { inherit config pkgs; })
    (import ../../modules/home-manager/tealdeer.nix { inherit config pkgs; })
    (import ../../modules/home-manager/bash.nix { inherit config pkgs; })
    # (import ../../modules/home-manager/neovim { inherit config pkgs lib; })
    (import ../../modules/home-manager/fzf.nix { inherit config pkgs; })
    {
      ripgrep.enable = true;
      tmux.enable = true;
      bat.enable = true;
      htop.enable = true;
      mpv.enable = true;
      direnv = {
        enable = true;
        enableBashIntegration = true; # see note on other shells below
        nix-direnv.enable = true;
      };
    }
  ];

  home.packages = lib.mkMerge [
    (lib.mkIf (hostName == "epimetheus") my_packages.kde_packages)
    my_packages.user_packages
    my_packages.commandline_tools
    [ inputs.nix-gaming.packages.x86_64-linux.star-citizen ]
  ];

  home.stateVersion = "23.05";
}

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

  programs = lib.mkMerge [
    (import ../../modules/home-manager/alacritty.nix {inherit config pkgs;})
    (import ../../modules/home-manager/bash.nix {inherit config pkgs;})
    (import ../../modules/home-manager/bash.nix {inherit config pkgs;})
    (import ../../modules/home-manager/eza.nix {inherit config pkgs;})
    (import ../../modules/home-manager/firefox.nix {inherit config inputs pkgs lib;})
    (import ../../modules/home-manager/fzf.nix {inherit config pkgs;})
    (import ../../modules/home-manager/git.nix {inherit config pkgs;})
    (import ../../modules/home-manager/man.nix {inherit config pkgs;})
    # (import ../../modules/home-manager/neovim { inherit config pkgs lib; })
    (import ../../modules/home-manager/nix-index.nix {inherit config pkgs;})
    (import ../../modules/home-manager/oh-my-posh.nix {inherit config pkgs;})
    (import ../../modules/home-manager/tealdeer.nix {inherit config pkgs;})
    (import ../../modules/home-manager/vscode.nix {inherit config pkgs;})
    {
      bat.enable = true;
      direnv = {
        enable = true;
        enableBashIntegration = true; # see note on other shells below
        nix-direnv.enable = true;
      };
      htop.enable = true;
      mpv.enable = true;
      ripgrep.enable = true;
      tmux.enable = true;
      yt-dlp.enable = true; #to play some music with mpv
    }
  ];
}

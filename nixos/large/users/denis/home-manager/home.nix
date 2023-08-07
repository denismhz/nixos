{ config, pkgs, ... }:
let
  default = import ../../../../share/home-manager/default.nix;
  alacrittyConfig = import ./programs/alacritty.nix;
  bashConfig = import ./programs/bash.nix;
  exaConfig = import ./programs/exa.nix;
  gitConfig = import ./programs/git.nix;
  librewolfConfig = import ./programs/librewolf.nix;
  manConfig = import ./programs/man.nix;
  neovimConfig = import ./programs/nvim.nix;
  nix-indexConfig = import ./programs/nix-index.nix;
  ompConfig = import ./programs/omp.nix;
  plasmaConfig = import ./programs/plasma.nix;
  tealdeerConfig = import ./programs/tealdeer.nix;
  vscodeConfig = import ./programs/vscode.nix;
in
{
  home.username = "denis";
  home.homeDirectory = "/home/denis";

  #programs.alacritty = alacrittyConfig pkgs;
  #programs = default;
  programs = {
    #alacritty = alacrittyConfig pkgs;
    
    
 
  };
  programs.bash = bashConfig pkgs;
  programs.exa = exaConfig pkgs;
  programs.git = gitConfig pkgs;
  programs.librewolf = librewolfConfig pkgs;
  programs.man = manConfig pkgs;
  programs.neovim = neovimConfig pkgs;
  programs.nix-index = nix-indexConfig pkgs;
  programs.oh-my-posh = ompConfig pkgs;
  programs.plasma = plasmaConfig pkgs;
  programs.tealdeer = tealdeerConfig pkgs;
  programs.vscode = vscodeConfig pkgs;

  xsession.enable = true;
  xsession.numlock.enable = true;

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}

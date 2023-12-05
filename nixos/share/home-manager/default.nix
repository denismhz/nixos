{ config, pkgs, ... }:
let
  alacrittyConfig = import ./alacritty.nix;
  bashConfig = import ./bash.nix;
  ezaConfig = import ./eza.nix;
  gitConfig = import ./git.nix;
  librewolfConfig = import ./librewolf.nix;
  manConfig = import ./man.nix;
  neovimConfig = import ./nvim;
  nix-indexConfig = import ./nix-index.nix;
  ompConfig = import ./omp.nix;
  tealdeerConfig = import ./tealdeer.nix;
in
{
  alacritty = alacrittyConfig pkgs;
  bash = bashConfig pkgs;
  #exa was replaced by eza
  eza = ezaConfig pkgs;
  git = gitConfig pkgs;
  librewolf = librewolfConfig pkgs;
  man = manConfig pkgs;
  neovim = neovimConfig pkgs;
  nix-index = nix-indexConfig pkgs;
  oh-my-posh = ompConfig pkgs;
  home-manager.enable = true;
  tealdeer = tealdeerConfig pkgs;
}

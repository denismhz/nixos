{ config, pkgs, ... }:
let
  alacrittyConfig = import ./alacritty.nix;
  bashConfig = import ./bash.nix;
  exaConfig = import ./exa.nix;
  gitConfig = import ./git.nix;
  librewolfConfig = import ./librewolf.nix;
  manConfig = import ./man.nix;
  neovimConfig = import ./nvim.nix;
  nix-indexConfig = import ./nix-index.nix;
  ompConfig = import ./omp.nix;
in
{
  alacritty = alacrittyConfig pkgs;
  bash = bashConfig pkgs;
  exa = exaConfig pkgs;
  git = gitConfig pkgs;
  librewolf = librewolfConfig pkgs;
  man = manConfig pkgs;
  neovim = neovimConfig pkgs;
  nix-index = nix-indexConfig pkgs;
  oh-my-posh = ompConfig pkgs;
  home-manager.enable = true;
}

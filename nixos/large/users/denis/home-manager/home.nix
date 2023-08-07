{ config, pkgs, lib, ... }:
let
  default = import ../../../../share/home-manager/default.nix;
  plasmaConfig = import ./programs/plasma.nix;
  tealdeerConfig = import ./programs/tealdeer.nix;
  vscodeConfig = import ./programs/vscode.nix;
in
{
  home.username = "denis";
  home.homeDirectory = "/home/denis";

  programs = lib.mkMerge [
    (default pkgs)
    {
      plasma = plasmaConfig pkgs;
      tealdeer = tealdeerConfig pkgs;
      vscode = vscodeConfig pkgs;
    }
  ];


  xsession.enable = true;
  xsession.numlock.enable = true;

  home.stateVersion = "23.05";
}

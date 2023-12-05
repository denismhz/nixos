{ config, pkgs, lib, ... }:
let
  default = import ../../../../share/home-manager/default.nix;
  #plasmaConfig = import ./programs/plasma.nix;
  vscodeConfig = import ./programs/vscode.nix;
in
{
  home.username = "denis";
  home.homeDirectory = "/home/denis";

  programs = lib.mkMerge [
    (default pkgs)
    {
      #plasma = plasmaConfig pkgs;
      vscode = vscodeConfig pkgs;
      firefox.enable = true;
      eww.enable = true;
      eww.configDir = config.lib.file.mkOutOfStoreSymlink ./eww-config;
    }
  ];

  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };

  #xsession.enable = true;
  #xsession.numlock.enable = true;

  home.stateVersion = "23.05";
}

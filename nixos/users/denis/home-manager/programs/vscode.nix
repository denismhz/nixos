{ config, pkgs, ... }:
{
  enable = true;
  package = pkgs.vscodium;
  extensions = with pkgs.vscode-extensions; [
    jnoortheen.nix-ide
    arrterian.nix-env-selector
    mkhl.direnv
    ms-vscode-remote.remote-ssh
    yzhang.markdown-all-in-one
    pkief.material-icon-theme
    asvetliakov.vscode-neovim
  ];
  userSettings = {
    "terminal.integrated.fontFamily" = "DeJaVuSansM Nerd Font Mono";
    "window.zoomLevel" = "0.0";
    "window.menuBarVisibility" = "toggle";
  };
}

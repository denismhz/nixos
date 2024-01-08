{ config, pkgs, ... }:
{
  vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      arrterian.nix-env-selector
      mkhl.direnv
      ms-vscode-remote.remote-ssh
      yzhang.markdown-all-in-one
      pkief.material-icon-theme
      dracula-theme.theme-dracula
      tomoki1207.pdf
      ms-azuretools.vscode-docker
      sumneko.lua
      vscodevim.vim
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "qml-format";
        publisher = "Delgan";
        version = "1.0.4";
        sha256 = "sha256-G81ri81jlQ12FiomkkoQtW9H7W9dffDqQXhJ08/vwgk=";
      }
      {
        name = "QML";
        publisher = "bbenoist";
        version = "1.0.0";
        sha256 = "sha256-tphnVlD5LA6Au+WDrLZkAxnMJeTCd3UTyTN1Jelditk=";
      }
      {
        name = "prettier-vscode";
        publisher = "esbenp";
        version = "10.1.0";
        sha256 = "sha256-SQuf15Jq84MKBVqK6UviK04uo7gQw9yuw/WEBEXcQAc=";
      }
    ];
    userSettings = {
      "terminal.integrated.fontFamily" = "DeJaVuSansM Nerd Font Mono";
      "window.zoomLevel" = "0.0";
      "window.menuBarVisibility" = "toggle";
      "workbench.preferredDarkColorTheme" = "Dracula";
      "workbench.colorTheme" = "Dracula";
      "explorer.confirmDelete" = "false";
      "terminal.integrated.scrollback" = 10000;
      "nix.enableLanguageServer" = "true";
    };
  };
}

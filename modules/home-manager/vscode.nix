{
  config,
  pkgs,
  ...
}: {
  vscode = {
    enable = true;
    package = pkgs.vscodium;

    #package = pkgs.vscode.fhsWithPackages (ps: with ps; [ rustup zlib openssl.dev pkg-config ]);

    profiles.default.extensions = with pkgs.vscode-extensions;
      [
        arrterian.nix-env-selector
        dracula-theme.theme-dracula
        jnoortheen.nix-ide
        #llvm-vs-code-extensions.vscode-clangd
        mkhl.direnv
        ms-azuretools.vscode-docker
        ms-python.python
        ms-toolsai.jupyter
        ms-vscode.cmake-tools
        ms-vscode.cpptools
        #ms-vscode-remote.remote-ssh #no-work
        pkief.material-icon-theme
        sumneko.lua
        tomoki1207.pdf
        twxs.cmake
        vadimcn.vscode-lldb
        vscodevim.vim
        yzhang.markdown-all-in-one
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
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

    profiles.default.userSettings = {
      "terminal.integrated.fontFamily" = "DeJaVuSansM Nerd Font Mono";
      #"window.zoomLevel" = "0.0"; -> this is causing the trouble ?!
      "window.menuBarVisibility" = "toggle";
      "workbench.preferredDarkColorTheme" = "Dracula";
      "workbench.colorTheme" = "Dracula";
      "explorer.confirmDelete" = "false";
      "terminal.integrated.scrollback" = 10000;
      "nix.enableLanguageServer" = "true";
      "window.titleBarStyle" = "custom";
      "keyboard.dispatch" = "keyCode";
    };
  };
}

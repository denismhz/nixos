{ config, pkgs, ... }:
let
  nvimConfig = import ./programs/nvim.nix;
  bashConfig = import ./programs/bash.nix;
  alacrittyConfig = import ./programs/alacritty.nix;
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "denis";
  home.homeDirectory = "/home/denis";

  programs.bash = bashConfig pkgs;
  programs.alacritty = alacrittyConfig pkgs;
  programs.neovim = nvimConfig pkgs;

  programs.git = {
    enable = true;
    ignores = [
      "*~"
      "*.swp"
      "/node-modules"
    ];
    userEmail = "denis@manherz.de";
    userName = "Denis Manherz";

  };

  xsession.enable = true;
  xsession.numlock.enable = true;

  programs.vscode = {
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
      "window.zoomLevel" = 0.1;
      "window.menuBarVisibility" = "toggle";
    };
  };

  programs.librewolf = {
    enable = true;
    settings = {
      "webgl.disabled" = false;
    };
  };

  programs.tealdeer = {
    enable = true;
    settings = {
      display = {
        compact = true;
        use_pager = false;
      };
      updates = {
        auto_update = true;
      };
    };
  };

  programs.nix-index = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.man = {
    enable = true;
    generateCaches = true;
  };




  programs.oh-my-posh = {
    enable = true;
    enableBashIntegration = true;
    useTheme = "emodipt-extend";
  };


  programs.exa = {
    enable = true;
    enableAliases = true;
    git = true;
    icons = true;
    extraOptions = [
      "--group-directories-first"
      "--header"
      "--reverse"
    ];
  };

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}

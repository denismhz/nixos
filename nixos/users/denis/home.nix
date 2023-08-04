{ config, pkgs, ... }:
let
  nvimConfig = import ./nvim.nix;
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "denis";
  home.homeDirectory = "/home/denis";

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
    ];
    enableExtensionUpdateCheck = true;
    enableUpdateCheck = true;
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
        compact = false;
        use_pager = true;
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

  programs.neovim = nvimConfig pkgs;

  programs.bash.enable = true;

  programs.bash.bashrcExtra = ''
    # Aliases
    # ARCHIVE EXTRACTION
    ex ()
    {
      if [ -f "$1" ] ; then
        case $1 in
          *.tar.bz2)   tar xjf $1   ;;
          *.tar.gz)    tar xzf $1   ;;
          *.bz2)       bunzip2 $1   ;;
          *.rar)       unrar x $1   ;;
          *.gz)        gunzip $1    ;;
          *.tar)       tar xf $1    ;;
          *.tbz2)      tar xjf $1   ;;
          *.tgz)       tar xzf $1   ;;
          *.zip)       unzip $1     ;;
          *.Z)         uncompress $1;;
          *.7z)        7z x $1      ;;
          *.deb)       ar x $1      ;;
          *.tar.xz)    tar xf $1    ;;
          *.tar.zst)   unzstd $1    ;;
          *)           echo "'$1' cannot be extracted via ex()" ;;
        esac
      else
        echo "'$1' is not a valid file"
      fi
    }

    # enable/disable battery saving mode
    batterysave()
    {
      if [ "$1" ] ; then
        case $1 in 
          "enable") 
            sudo bash -c "echo 1 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode;"
            echo -e "\nBatterysaving mode enabled!";;
          "disable") 
            sudo bash -c "echo 0 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode;"
            echo -e "\nBatterysaving mode disabled!";;
          "status")
            if [ $(awk -b '{print}' '/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode') -eq 1 ]; then
              echo -e "\nBatterysaving mode enabled!"
            else
              echo -e "\nBatterysaving mode disabled!"
            fi;;
        esac
      else
        echo "No valid argument! (enable, disable, status)"
      fi
    }
  '';

  programs.bash.enableCompletion = true;
  programs.bash.historyControl = [ "erasedups" ];
  programs.bash.historyIgnore = [
    "ls"
    "cd"
    "exit"
  ];
  programs.bash.historySize = 10000;
  programs.bash.shellAliases = {
    # cd aliases
    ".." = "cd ..";
    "..." = "cd ../..";
    ".3" = "cd ../../..";
    ".4" = "cd ../../../..";
    ".5" = "cd ../../../../..";
    # confirm before overwriting something
    "cp" = "cp -i";
    "mv" = "mv -i";
    "rm" = "rm -i";
    # git aliases
    "dotfiles" = "git --git-dir=$HOME/repos/dotfiles --work-tree=$HOME";
  };

  programs.oh-my-posh = {
    enable = true;
    enableBashIntegration = true;
    useTheme = "emodipt-extend";
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding = {
          x = 5;
          y = 5;
        };
      };
      font = {
        size = 18.0;
        normal = {
          family = "DejaVuSansM Nerd Font Mono";
        };

      };
      colors = {
        primary = {
          background = "0x1a1b26";
          foreground = "0xc0caf5";
        };
        normal = {
          black = "0x15161e";
          red = "0xf7768e";
          green = "0x9ece6a";
          yellow = "0xe0af68";
          blue = "0x7aa2f7";
          magenta = "0xbb9af7";
          cyan = "0x7dcfff";
          white = "0xa9b1d6";
        };
        bright = {
          black = "0x414868";
          red = "0xf7768e";
          green = "0x9ece6a";
          yellow = "0xe0af68";
          blue = "0x7aa2f7";
          magenta = "0xbb9af7";
          cyan = "0x7dcfff";
          white = "0xc0caf5";
        };
      };
    };
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

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

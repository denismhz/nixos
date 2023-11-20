{ config, pkgs, ... }:
{
  enable = true;

  bashrcExtra = ''
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

    toggleopacity()
    {
      ## If alacritty.yml does not exist, raise an alert
      [[ ! -f ~/.config/alacritty/alacritty.yml ]] && \
        echo "alacritty.yml does not exist" && exit 0

      ## Fetch background_opacity from alacritty.yml
      opacity=$(awk '$1 == "opacity:" {print $2; exit}' \
        ~/.config/alacritty/alacritty.yml)
      
      echo $opacity

      ## Assign toggle opacity value
        case $opacity in
        1)
          toggle_opacity=0.9
          ;;
        *)
          toggle_opacity=1
          ;;
        esac

      ## Replace opacity value in alacritty.yml
      sed -i -- "s/opacity: $opacity/opacity: $toggle_opacity/" \
        ~/.config/alacritty/alacritty.yml

      echo "I am here"
    }
  '';

  enableCompletion = true;
  historyControl = [ "erasedups" ];
  historyIgnore = [
    "ls"
    "cd"
    "exit"
  ];
  historySize = 10000;
  shellAliases = {
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
}

{pkgs, ...}:
{
  enable = true;
  package = pkgs.waybar.overrideAttrs (oa: {
    mesonFlags = (oa.mesonFlags or  []) ++ [ "-Dexperimental=true" ];
    patches = (oa.patches or []) ++ [
      (pkgs.fetchpatch {
        name = "fix waybar hyprctl";
        url = "https://aur.archlinux.org/cgit/aur.git/plain/hyprctl.patch?h=waybar-hyprland-git";
        sha256 = "sha256-pY3+9Dhi61Jo2cPnBdmn3NUTSA8bAbtgsk2ooj4y7aQ=";
      })
    ];
  });
  style = ''
      @define-color red             #FF5555;
      @define-color dark_red        #BE5046;
      @define-color green           #50FA7B;
      @define-color yellow          #F1FA8C;
      @define-color dark_yellow     #D19A66;
      @define-color current_line    #44475A;
      @define-color comment         #6272A4;
      @define-color blue            #61AFEF;
      @define-color purple          #BD93F9;
      @define-color cyan            #56B6C2;
      @define-color white           #ABB2BF;
      @define-color grey            #5C6370;
      @define-color light           #c6cdda;
      @define-color black           #282C34;
      @define-color foreground      #F8F8F2;
      @define-color background      rgba(40, 42, 54, 1);
      @define-color trans           rgba(0, 0, 0, 0);

      * {
        font-size: 18px;
      }

      window#waybar {
        background-color: @background;
        color: @comment;
        border-radius: 0px;
      }

      window#wabar:hover {
        color: @purple;
      }

      #clock {
        padding-left: 10px;
      }

      button {
        box-shadow: none;
        border: none;
        border-radius: 0;
      }

      #workspaces button {
        color: @comment;
      }

      #workspaces button:hover {
        text-shadow: none;
        background: unset;
        color: @purple;
      }

      #workspaces button.active {
        color: @purple;
        border-bottom: 2px solid @purple;
      }

      #workspaces button.urgent {
        background-color: #eb4d4b;
      }

      #window {
        padding: 0 0px;
      }

      #tray {
        padding-right: 10px;
        color: @comment;
      }

      #battery.warning {
        color: @yellow;
        background: unset;
      }

      #battery.critical {
        color: @red;
        background: unset;
      }
      #battery.charging {
        color: @green;
        background: unset;
      }
    '';
    settings = [{
      "layer" = "top";
      "height" = 35;
      "spacing" = 10;
      "margin" = "0 0 0";
      "modules-left" = [
        "clock"
        "wlr/workspaces"
      ];
      "modules-center" = [
        "hyprland/window"
      ];
      "modules-right" = [
        "cpu"
        "memory"
        "disk"
        "backlight"
        "pulseaudio"
        "battery"
        "tray"
      ];
      "hyprland/window" = {
        "separate-outputs" = true;
      };
      "wlr/workspaces" = {
        "on-click" = "activate";
        "on-scroll-up" = "hyprctl dispatch workspace e+1";
        "on-scroll-down" = "hyprctl dispatch workspace e-1";
        "format" = "{icon}";
        "format-icons" = {
          "1" = "1 󰈹";
          "2" = "2 ";
          "3" = "3 ";
          "4" = "4 ";
          "5" = "5 ";
          "6" = "6 ";
          "7" = "7 ";
          "8" = "8 ";
          "9" = "9 ";
          "10" = "10 ";
        };
        "sort-by-name" = false;
        "sort-by-number" = true;
      };
      "cpu" = {
        "interval" = 5;
        "format" = "󰚗 {usage}%";
        "on-click" = "alacritty -e htop";
      };
      "backlight" = {
        "format" = "{icon} {percent}%";
        "format-icons" = [ "🌑" "🌒" "🌓" "🌔" "🌕" ];
        "on-click" = "brightnessctl set 50%";
        "on-scroll-up" = "brightnessctl set +5%";
        "on-scroll-down" = "brightnessctl set 5%-";
      };
      "memory" = {
        "interval" = 30;
        "format" = "󰍛 {percentage}% ";
        "max-length" = 10;
        "on-click" = "alacritty -e htop";
      };
      "battery" = {
        "bat" = "BAT0";
        "states" = {
            "good" = 95;
            "warning" = 30;
            "critical" = 15;
        };
        "format" = "{icon} {}%";
        "design-capacity" = true;
        "format-icons" = ["󰂎" "󰁻" "󰁽" "󰂀" "󰁹"];
        "format-charging" = "󰂄 {}%";
        "tooltip" = true;
        "tooltip-format" = "{capacity}%, {timeTo}";
      };
      "pulseaudio" = {
        "format" = "{icon} {volume}%";
        "format-muted" = "󰝟 {volume}%";
        "format-icons" = {
          "headphone" = [ "" "" ];
          "default" = [ "" "" "" ];
        };
        "on-click-right" = "pavucontrol";
        "on-click" = "pamixer -t";
        "on-scroll-up" = "pamixer -i 5";
        "on-scroll-down" = "pamixer -d 5";
      };
      "clock" = {
        "interval" = 1;
        "format" = "{:%d/%m/%y, %R}";
        "timezone" = "Europe/Berlin";
        "tooltip" = true;
        "tooltip-format" = "<tt>{calendar}</tt>";
      };
      "disk" = {
        "interval" = 30;
        "format" = " {percentage_used}%";
        "path" = "/";
        "on-click" = "dolphin";
      };
      "tray" = {
        "spacing" = 10;
      };
    }];
}




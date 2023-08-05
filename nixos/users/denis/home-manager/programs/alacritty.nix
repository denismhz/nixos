{ config, pkgs, ... }:
{
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
}

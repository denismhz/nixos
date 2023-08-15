{ config, pkgs, ... }:
{
  enable = true;
  settings = {
    window = {
      opacity = 0.95;
      dynamic_title = true;
      dynamic_padding = true;
      decorations = "full";
      dimensions = { lines = 0; columns = 0; };
      padding = { x = 5; y = 5; };
    };

    scrolling = {
      history = 10000;
      multiplier = 3;
    };

    mouse = { hide_when_typing = true; };

    key_bindings = [
      {
        # clear terminal
        key = "L";
        mods = "Control";
        chars = "\\x0c";
      }
    ];

    font = let fontname = "DeJaVuSansM Nerd Font Mono"; in
      {
        normal = { family = fontname; style = "Bold"; };
        bold = { family = fontname; style = "Bold"; };
        italic = { family = fontname; style = "Light"; };
        size = 18;
      };
    cursor.style = "Beam";

    colors = {
      primary = {
        background = "0x282a36";
        foreground = "0xf8f8f2";
        bright_foreground = "0xffffff";
      };
      cursor = {
        text = "CellBackground";
        cursor = "CellForeground";
      };
      vi_mode_cursor = {
        text = "CellBackground";
        cursor = "CellForeground";
      };
      search = {
        matches = {
          foreground = "#44475a";
          background = "#50fa7b";
        };
        focused_match = {
          foreground = "#44475a";
          background = "#ffb86c";
        };
      };
      footer_bar = {
        background = "#282a36";
        foreground = "#f8f8f2";
      };
      hints = {
        start = {
          foreground = "#282a36";
          background = "#f1fa8c";
        };
        end = {
          foreground = "#f1fa8c";
          background = "#282a36";
        };
      };
      line_indicator = {
        foreground = "None";
        background = "None";
      };
      selection = {
        text = "CellForeground";
        background = "#44475a";
      };
      normal = {
        black = "0x21222c";
        red = "0xff5555";
        green = "0x50fa7b";
        yellow = "0xf1fa8c";
        blue = "0xbd93f9";
        magenta = "0xff79c6";
        cyan = "0x8be9fd";
        white = "0xf8f8f2";
      };
      bright = {
        black = "0x6272a4";
        red = "0xff6e6e";
        green = "0x69ff94";
        yellow = "0xffffa5";
        blue = "0xd6acff";
        magenta = "0xff92df";
        cyan = "0xa4ffff";
        white = "0xffffff";
      };
    };
  };
}
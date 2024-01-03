{pkgs,...}:
{
  enable = true;
  #enableNvidiaPatches = true;
  plugins = [];
  extraConfig = builtins.readFile ./hyprland.conf;
}

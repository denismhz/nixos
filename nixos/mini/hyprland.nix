{pkgs,...}:
{
  enable = true;
  nvidiaPatches = true;
  plugins = [];
  extraConfig = builtins.readFile ./hyprland.conf;
}

{pkgs, ...}: {
  hyprland = {
    enable = true;
    xwayland.enable = true;
    package = pkgs.unstable.hyprland;
    #enableNvidiaPatches = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };
}

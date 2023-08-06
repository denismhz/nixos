{ config, pkgs, ... }:
{
  enable = true;
  workspace.clickItemTo = "select";
  configFile."kglobalshortcutsrc"."kwin"."Window Maximize Horizontal" = "Alt+M,,Maximize Window Horizontally";
  configFile."kglobalshortcutsrc"."ksmserver"."Lock Session" = "Meta+L\tScreensaver\tAlt+L,Meta+L\tScreensaver,Lock Session";
  /*  configFile."kglobalshortcutsrc"."librewolf.desktop"."new-private-window" = "none,none,New Private Window";
    configFile."kglobalshortcutsrc"."librewolf.desktop"."new-window" = "none,none,New Window";
  configFile."kglobalshortcutsrc"."librewolf.desktop"."profile-manager-window" = "none,none,Profile Manager"; */
}

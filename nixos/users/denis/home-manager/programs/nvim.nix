{ config, pkgs, ... }:

{
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraConfig = ''
    
    '';

    plugins = with pkgs.vimPlugins; [];
}

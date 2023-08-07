{ config, pkgs, ... }: 
let
  alacrittyConfig = import ./alacritty.nix;
in
{ 
  alacritty = alacrittyConfig pkgs;
}

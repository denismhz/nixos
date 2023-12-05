{ config, pkgs, ... }:
{
  enable = true;
  enableAliases = true;
  git = true;
  icons = true;
  extraOptions = [
    "--group-directories-first"
    "--header"
    "--git"
  ];
}

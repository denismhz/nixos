{ config, pkgs, ... }:
{
  enable = true;
  ignores = [
    "*~"
    "*.swp"
    "/node-modules"
  ];
  userEmail = "denis@manherz.de";
  userName = "Denis Manherz";
}

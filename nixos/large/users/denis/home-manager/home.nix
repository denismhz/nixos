{ config, pkgs, lib, ... }:
let
  default = import ../../../../share/home-manager/default.nix;
  plasmaConfig = import ./programs/plasma.nix;
  vscodeConfig = import ./programs/vscode.nix;
in
{
  home.username = "denis";
  home.homeDirectory = "/home/denis";

  programs = lib.mkMerge [
    (default pkgs)
    {
      plasma = plasmaConfig pkgs;
      vscode = vscodeConfig pkgs;
      firefox.enable = true;
      eww.enable = true;
      eww.configDir = config.lib.file.mkOutOfStoreSymlink ./eww-config;
      autorandr.enable = true;
      autorandr.profiles =
        {
          "dual-monitor" = {
            fingerprint = {
              DP-4 = "00ffffffffffff0009e5400a00000000101f0104b5221578037ce5a4554c9f260f5054000000010101010101010101010101010101016b6e00a0a04084603020360058d71000001a000000fd0c3ca51f1f4e010a202020202020000000fe00424f452043510a202020202020000000fe004e4531363051444d2d4e59310a023b02031d00e3058000e60605016a6a246d1a000002033ca500046a246a240000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001fe7013790000030114a52f0185ff099f002f001f003f0683000200050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003e90";
              HDMI-0 = "00ffffffffffff001e6db85a010101010118010380301b78ea3135a5554ea1260c5054a54b00714f81809500b300a9c0810081c09040023a801871382d40582c4500e00e1100001e000000fd00384b1e530f000a202020202020000000fc004c47204950532046554c4c4844000000ff000a202020202020202020202020016402031df14a900403011412051f1013230907078301000065030c001000023a801871382d40582c4500e00e1100001e011d8018711c1620582c2500e00e1100009e011d007251d01e206e285500e00e1100001e8c0ad08a20e02d10103e9600e00e110000180000000000000000000000000000000000000000000000000000ae";
            };
            config = {
              DP-4 = {
                enable = true;
                mode = "2560x1600";
                position = "2560x0";
                rate = "165.00";
                rotate = "normal";
              };
              HDMI-0 = {
                enable = true;
                primary = true;
                position = "0x0";
                mode = "1920x1080";
                gamma = "1.0:0.909:0.833";
                rate = "60.00";
                rotate = "normal";
                scale = {method="factor";x=1.333333; y=1.333333;};
              };
            };
            hooks.postswitch = builtins.readFile ./dual-monitor-postswitch.sh;
          };
        };
    }
  ];

  #services.autorandr.enable = true;

  xsession.enable = true;
  xsession.numlock.enable = true;

  home.stateVersion = "23.05";
}

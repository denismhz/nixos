{
  lib,
  config,
  pkgs,
  ...
}: {
  # Define a user account. Don't forget to set a password with  ^`^xpasswd ^`^y.
  users.users.hypruser = {
    isNormalUser = true;
    description = "Hyprland-User";
    extraGroups = ["networkmanager" "wheel" "video" "render" "libvirtd"];
    packages = with pkgs; [
      brightnessctl
      dracula-theme
      kdePackages.polkit-kde-agent-1
      dunst
      pamixer
      wlr-randr
      #dolphin
      hyprpaper
      networkmanagerapplet
      pavucontrol
    ];
    hashedPassword = "$y$j9T$0opCRT4e3X3P.tqGvEGd91$9cW/JMGTCfcEzkw9m6cemqSoNBrd5O6A3JCO3eitdO9";
  };
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];
  # Enable automatic login for the user.

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Open Firewall Ports for KDE Connect
  networking.firewall.allowedTCPPortRanges = [
    {
      from = 1714;
      to = 1764;
    }
  ];
  networking.firewall.allowedUDPPortRanges = [
    {
      from = 1714;
      to = 1764;
    }
  ];

  # Enable samba wsdd
  services.samba-wsdd.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.dejavu-sans-mono
  ];
}

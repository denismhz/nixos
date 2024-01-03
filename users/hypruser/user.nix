{ lib, config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with  ^`^xpasswd ^`^y.
  users.users.hypruser = {
    isNormalUser = true;
    description = "Hyprland-User";
    extraGroups = [ "networkmanager" "wheel" "video" "render" "libvirtd" ];
    packages = with pkgs; [
      libsForQt5.qt5.qtquickcontrols2
      libsForQt5.qt5.qtgraphicaleffects
      libsForQt5.qt5ct
      libsForQt5.qtstyleplugin-kvantum
      qt6.qtwayland
      brightnessctl
      dracula-theme
      libsForQt5.polkit-kde-agent
      dunst
      pamixer
      rnix-lsp
      wlr-randr
      dolphin
      hyprpaper
      networkmanagerapplet
      pavucontrol
      htop
      wl-clipboard
    ];
    hashedPassword = "$y$j9T$0opCRT4e3X3P.tqGvEGd91$9cW/JMGTCfcEzkw9m6cemqSoNBrd5O6A3JCO3eitdO9";
  };

  # Enable automatic login for the user.
  services.xserver.displayManager = {
    sddm.enable = true;
    autoLogin.enable = false;
    autoLogin.user = "denis";
    sddm.theme = "sddm-chili";
  };

  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  programs.dconf.enable = true;

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
    (nerdfonts.override { fonts = [ "DejaVuSansMono" ]; })
  ];
}

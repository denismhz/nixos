{ config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with  ^`^xpasswd ^`^y.
  users.users.denis = {
    isNormalUser = true;
    description = "Denis Manherz";
    extraGroups = [ "networkmanager" "wheel" "video" "render" "libvirtd" ];
    packages = (import ./packages.nix pkgs).user_packages;
    hashedPassword = "$y$j9T$0opCRT4e3X3P.tqGvEGd91$9cW/JMGTCfcEzkw9m6cemqSoNBrd5O6A3JCO3eitdO9";
  };

  environment.sessionVariables.MOZ_ENABLE_WAYLAND = "1";
  environment.sessionVariables.MOZ_USE_XINPUT2 = "1";

  # services.packagekit.enable = true;

  programs.git.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.steam = {
    enable = true;
    # remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    # dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
  programs.gamemode.enable = true;
  hardware.steam-hardware.enable = true;

  programs.noisetorch.enable = true;
  # environment.etc."chromium/native-messaging-hosts/org.kde.plasma.browser_integration.json".source = "${pkgs.plasma-browser-integration}/etc/chromium/native-messaging-hosts/org.kde.plasma.browser_integration.json";

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "denis";

  services.xserver.libinput.enable = true;

  services.xserver.libinput.mouse = {
    accelProfile = "flat";
    accelSpeed = null;
  };

  services.xserver.libinput.touchpad = {
    disableWhileTyping = true;
  };

  services.xserver.displayManager.sddm = {
    enable = true;
    #autoLogin.relogin = true;
    autoNumlock = true;
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
  # Firewall Ports for samba
  networking.firewall.allowedTCPPorts = [
    5357 # samba
    #24727 # ausweisapp2
  ];
  networking.firewall.allowedUDPPorts = [
    3702 # samba
    #24727 # ausweisapp2
  ];

  # Enable samba wsdd
  services.samba-wsdd.enable = true;

  #services.mongodb = {
  #  enable = true;
    #dbpath = "/home/denis/mongodb";
  #};

  environment.sessionVariables = {
    NIX_PROFILES = "${pkgs.lib.concatStringsSep " " (pkgs.lib.reverseList config.environment.profiles)}";
    NIXOS_OZONE_WL = "1";
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "DejaVuSansMono" "DroidSansMono" ]; })
  ];
}

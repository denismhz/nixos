{ config, pkgs, unstable, ... }:

{
  # Define a user account. Don't forget to set a password with  ^`^xpasswd ^`^y.
  users.users.denis = {
    isNormalUser = true;
    description = "Denis Manherz";
    extraGroups = [ "networkmanager" "wheel" "video" "render" "libvirtd" ];
    packages = (import ./packages.nix { pkgs = pkgs; unstable = unstable; config = config; }).user_packages;
    hashedPassword = "$y$j9T$0opCRT4e3X3P.tqGvEGd91$9cW/JMGTCfcEzkw9m6cemqSoNBrd5O6A3JCO3eitdO9";
  };

  environment.sessionVariables.MOZ_ENABLE_WAYLAND = "1";
  environment.sessionVariables.MOZ_USE_XINPUT2 = "1";

  # services.packagekit.enable = true;

  programs.noisetorch.enable = true;

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


  programs.steam = {
    enable = true;
    # remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    # dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
  programs.gamemode.enable = true;
  hardware.steam-hardware.enable = true;

  #environment.sessionVariables = {
  #  NIX_PROFILES = "${pkgs.lib.concatStringsSep " " (pkgs.lib.reverseList config.environment.profiles)}";
  #  NIXOS_OZONE_WL = "1";
  #};

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "DejaVuSansMono" "DroidSansMono" ]; })
  ];
}

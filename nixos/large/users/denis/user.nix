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
  users.users.guest = { isNormalUser = true; };
  # Enable automatic login for the user.
  services.xserver.displayManager = {
    sddm.enable = true;
    autoLogin.enable = false;
    autoLogin.user = "denis";
    sddm.theme = "sddm-sugar-dracula";
  };

  # mouse touchpad input config
  services.xserver.libinput = {
    enable = true;
    mouse = {
      accelProfile = "flat";
      accelSpeed = null;
    };
    touchpad = {
      disableWhileTyping = true;
    };
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
    5173 # vite dev
    4173 # vite preview
    #24727 # ausweisapp2
  ];
  networking.firewall.allowedUDPPorts = [
    3702 # samba
    #24727 # ausweisapp2
  ];

  # Enable samba wsdd
  services.samba-wsdd.enable = true;

  # Steam
  programs.steam.enable = true;
  programs.gamemode.enable = true;
  hardware.steam-hardware.enable = true;

  services.mongodb = {
    enable = true;
    dbpath = "/var/lib/mongodb";
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "DejaVuSansMono" ]; })
  ];
}

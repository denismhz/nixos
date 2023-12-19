{ lib, config, pkgs, unstable, ... }:

{
  # Define a user account. Don't forget to set a password with  ^`^xpasswd ^`^y.
  users.users.denis = {
    isNormalUser = true;
    description = "Denis Manherz";
    extraGroups = [ "networkmanager" "wheel" "video" "render" "libvirtd" ];
    packages = (import ./packages.nix { inherit unstable pkgs config; }).user_packages;
    hashedPassword = "$y$j9T$0opCRT4e3X3P.tqGvEGd91$9cW/JMGTCfcEzkw9m6cemqSoNBrd5O6A3JCO3eitdO9";
  };

  services.a1111 = {
    enable = true;
    user = "denis";
    group = "users";
    extraArgs = ["--no-download-sd-model" "--medvram" "--no-half-vae" ];
    settings.ckpt-dir = "/home/denis/.invokeai/autoimport/main";
  };
  systemd.services.a1111.serviceConfig.Restart = lib.mkForce "always";

  # Enable automatic login for the user.
  services.xserver.displayManager = {
    sddm.enable = true;
    autoLogin.enable = false;
    autoLogin.user = "denis";
    sddm.theme = "sddm-chili";
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
    7860 # a1111
  ];
  networking.firewall.allowedUDPPorts = [
    3702 # samba
  ];

  # Enable samba wsdd
  services.samba-wsdd.enable = true;

  # Steam
  programs.steam.enable = true;
  programs.gamemode.enable = true;
  hardware.steam-hardware.enable = true;

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "DejaVuSansMono" ]; })
  ];
}

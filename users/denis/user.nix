{
  lib,
  pkgs,
  config,
  ...
}: let
  hostname = config.networking.hostName;
in {
  # Define a user account. Don't forget to set a password with  ^`^xpasswd ^`^y.
  # Initial definition of user account in machine configuration
  # extra settings here
  users.users.denis = {
    description = "Denis Manherz";
    extraGroups = ["networkmanager" "wheel" "video" "render" "libvirtd"];
    hashedPassword = "$y$j9T$0opCRT4e3X3P.tqGvEGd91$9cW/JMGTCfcEzkw9m6cemqSoNBrd5O6A3JCO3eitdO9";
  };

  services =
    if (hostname == "epimetheus")
    then {
      surrealdb = {
        enable = true;
        package = pkgs.unstable.surrealdb;
      };
      a1111 = {
        enable = false;
        user = "denis";
        group = "users";
        extraArgs = ["--no-download-sd-model" "--medvram" "--no-half-vae"];
        settings.ckpt-dir = "/home/denis/.invokeai/autoimport/main";
      };
      mongodb = {
        enable = true;
        dbpath = "/var/lib/mongodb";
      };
      # Enable samba wsdd
      samba-wsdd.enable = true;
    }
    else {};

  #systemd.services.a1111.serviceConfig.Restart = lib.mkForce "always";

  networking.firewall = {
    allowedTCPPortRanges = [
      {
        #KDE Connect
        from = 1714;
        to = 1764;
      }
    ];
    # Firewall Ports for samba
    allowedTCPPorts = [
      5357 # samba
      5173 # vite dev
      4173 # vite preview
      7860 # a1111
      8088 # comfyui
      3000 # leptos
    ];
    allowedUDPPorts = [
      3702 # samba
    ];
  };

  # Steam
  programs = lib.mkIf (hostname == "epimetheus") {
    steam.enable = true;
    gamemode.enable = true;
  };
  hardware = lib.mkIf (hostname == "epimetheus") {
    steam-hardware.enable = true;
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["DejaVuSansMono" "JetBrainsMono" "Iosevka"];})
    font-awesome
    comic-mono
  ];
}

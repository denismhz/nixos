# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [./sd-image.nix];
  boot = {
    loader.grub.enable = false;
    loader.generic-extlinux-compatible.enable = true;
    swraid.enable = lib.mkForce false;
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  services = {
    openssh.enable = true;
    getty.autologinUser = "denis";
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  sops.defaultSopsFile = ../../secrets/example.yaml;
  sops.age.keyFile = "/home/denis/.config/sops/age/keys.txt";
  sops.secrets.wifi-home = {};

  # Enable networking
  networking = {
    interfaces."wlan0".useDHCP = true;
    wireless = {
      enable = true;
      interfaces = ["wlan0"];
      environmentFile = config.sops.secrets.wifi-home.path;
      networks = {
        "Wi-Fi" = {
          psk = "@PASS_WIFI_HOME@";
        };
      };
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "de-latin1-nodeadkeys";

  users.users.denis = {
    isNormalUser = true;
    description = "Denis Manherz";
    extraGroups = ["networkmanager" "wheel"];
    hashedPassword = "$6$oX.O2Mko21Cf54fp$5oTmvbnorrqDYvpa8LMtp32fXhzgitHG9AEhTiL3NfmrpaBwbgZ4w0Wejq943O67M1lHxbMtIRIQk3hNuzNlD1";
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOyS5fFOZbcZYMMYJdVSG7YTYhx+ulFmjzdXGq3xgqtr denis@manherz.de"];
  };

  environment.systemPackages = with pkgs; [
    vim
  ];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  hardware = {
    enableRedistributableFirmware = lib.mkForce false;
    firmware = [pkgs.raspberrypiWirelessFirmware];
  };

  # hardware = {
  #   opengl.enable = true;
  # };

  programs.git.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

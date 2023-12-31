# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{

  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ];

# Bootloader.
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos-rpi-denis"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "systemd-resolved";

  services.resolved.enable = true;

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

# Configure keymap in X11
  #services.xserver = {
  #  layout = "de";
  #  xkbVariant = "nodeadkeys";
  #};

# Configure console keymap
  console.keyMap = "de-latin1-nodeadkeys";

# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.denis = {
    isNormalUser = true;
    description = "Denis Manherz";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

# Enable automatic login for the user.
#services.getty.autologinUser = "denis";

# Allow unfree packages
  #nixpkgs.config.allowUnfree = true;

# List packages installed in system profile. To search, run:
# $ nix search wget
  environment.systemPackages = with pkgs; [
    #libsForQt5.qt5.qtquickcontrols2
    #libsForQt5.qt5.qtgraphicaleffects
    #libsForQt5.qt5ct
    #libsForQt5.qtstyleplugin-kvantum
    #(pkgs.callPackage ../share/themes/sddm-theme.nix { })
    #rnix-lsp
    neovim
  ];

  #sound.enable = true;
  #hardware.pulseaudio.enable = false;
  #security.rtkit.enable = true;
  #services.pipewire = {
  #  enable = true;
  #  alsa.enable = true;
  #  alsa.support32Bit = true;
  #  pulse.enable = true;
  #};

  services.xserver.enable = true;

  hardware = {
    opengl.enable = true;
  };

  programs.git.enable = true;

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

# Enable the OpenSSH daemon.
# services.openssh.enable = true;

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
  system.stateVersion = "23.05"; # Did you read the comment?

}

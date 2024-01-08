{ config, pkgs, lib, services, unstable, ... }: {
  imports =
    [
      ./hardware-configuration.nix
      ../../users/denis/user.nix
      ../../users/hypruser/user.nix
    ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.trusted-users = [ "root" "@wheel" "denis" ];
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Auto system update
  system.autoUpgrade.flake = ./../flake.nix;

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernel.sysctl = { "vm.swappiness" = 5; };
  # Fix black screen on a system with an integrated GPU
  boot.kernelParams = [ "pcie_aspm=off" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    lenovo-legion-module
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor = false;
  boot.loader.systemd-boot.configurationLimit = 15;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "epimetheus";
  networking.networkmanager.enable = true;

  ##Services
  #arbtt does not work with wayland
  #services.arbtt.enable = true;
  #services.arbtt.logFile = "/home/denis/.arbtt/capture.log";

  # Printing
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  # for a WiFi printer
  services.avahi.openFirewall = true;

  services.smartd.enable = true;

  # NVIDIA drivers are unfree.
  services.xserver.videoDrivers = [ "nvidia" ];

  # Firmware
  services.fwupd.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.desktopManager.plasma5 = {
    enable = true;
    notoPackage = pkgs.noto-fonts-cjk-sans;
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "de";
    xkbVariant = "nodeadkeys";
  };

  # Enable automatic login for the user.
  services.xserver.displayManager = {
    sddm.enable = true;
    autoLogin.enable = false;
    autoLogin.user = "denis";
    sddm.theme = "sddm-chili";
  };

  # Launch KDE in Wayland session
  services.xserver.displayManager.defaultSession = "plasmawayland";

  # Enable flatpak
  services.flatpak.enable = true;

  #ENV vars
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.pathsToLink = [ "/share/bash-completion" ];

  #what does this one do ?
  environment.plasma5.excludePackages = [
    pkgs.libsForQt5.oxygen
    pkgs.libsForQt5.elisa
    pkgs.libsForQt5.plasma-sdk
  ];

  # NixOS configuration for Star Citizen requirements
  zramSwap.enable = true;
  boot.kernel.sysctl = {
    "vm.max_map_count" = 16777216;
    "fs.file-max" = 524288;
  };

  environment.systemPackages = with pkgs; [
    lenovo-legion
    virt-manager
    nixpkgs-fmt
    dracula-theme
    (pkgs.callPackage ../../modules/themes/sddm-chilli.nix { })
    wget
    vim
  ];

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
    LC_TELEPHONE =
      "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  i18n.supportedLocales = [
    "C.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
    "en_GB.UTF-8/UTF-8"
    "de_DE.UTF-8/UTF-8"
  ];

  programs.dconf.enable = true;
  programs.noisetorch.enable = true;

  # Configure console keymap
  console.keyMap = "de-latin1-nodeadkeys";

  # Enable sound with pipewire.
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  virtualisation.libvirtd.enable = true;

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-kde
      ];
    };
  };

  #additional hardware things
  hardware.enableAllFirmware = true;

  hardware.bluetooth.enable = true;

  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.powerManagement.enable = false;
  hardware.nvidia.prime.offload.enable = false;

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    driSupport = true;
    extraPackages = with pkgs; [
      libvdpau-va-gl
      nvidia-vaapi-driver
      vaapiVdpau
      vdpauinfo
      vulkan-validation-layers
      vulkan-tools
    ];
  };

  # if packets are still dropped, they will show up in dmesg
  networking.firewall.logReversePathDrops = true;

  system.stateVersion = "23.05";
}

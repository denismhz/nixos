{ config, pkgs, lib, services, unstable, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./users/denis/user.nix
    ];

  nix.settings.trusted-users = [ "root" "@wheel" "denis" ];

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor = false;
  boot.loader.systemd-boot.configurationLimit = 15;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nixos-denis";
  networking.networkmanager.enable = true;

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

  i18n.supportedLocales = [
    "C.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
    "en_GB.UTF-8/UTF-8"
    "de_DE.UTF-8/UTF-8"
  ];

  # Printing
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  # for a WiFi printer
  services.avahi.openFirewall = true;

  # Firmware
  services.fwupd.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.desktopManager.plasma5 = {
    enable = true;
    notoPackage = pkgs.noto-fonts-cjk-sans;
  };

  environment.pathsToLink = [ "/share/bash-completion" ];

  environment.plasma5.excludePackages = [
    #pkgs.libsForQt5.oxygen
    #pkgs.libsForQt5.elisa
    #pkgs.libsForQt5.plasma-sdk
  ];
  # Launch KDE in Wayland session
  #services.xserver.displayManager.defaultSession = "plasmawayland";

  # Apply GTK themes to Wayland applications
  programs.dconf.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "de";
    xkbVariant = "nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "de-latin1-nodeadkeys";

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable flatpak
  services.flatpak.enable = true;

  virtualisation.libvirtd.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    virt-manager
    direnv
    nixpkgs-fmt
    dracula-theme

    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
  ];



  # Fix black screen on a system with an integrated GPU
  boot.kernelParams = [ "module_blacklist=amdgpu" "pcie_aspm=off" ];

  hardware.enableAllFirmware = true;

  nixpkgs.config.allowUnfree = true;

  # NVIDIA drivers are unfree.
  services.xserver.videoDrivers = [ "nvidia" ];
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

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-kde
      ];
    };
  };

  hardware.bluetooth.enable = true;

  # nvidia-drm.modeset=1 is required for some wayland compositors, e.g. sway
  hardware.nvidia.modesetting.enable = true;

  # Fix graphical corruption on suspend/resume
  hardware.nvidia.powerManagement.enable = true;

  services.smartd.enable = true;

  # Auto system update
  #system.autoUpgrade.enable = true;

  boot.kernel.sysctl = { "vm.swappiness" = 5; };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];



  # if packets are still dropped, they will show up in dmesg
  networking.firewall.logReversePathDrops = true;

  /*   # wireguard trips rpfilter up (57934 -> wg endpoint port)
    networking.firewall.extraCommands = ''
    ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 57934 -j RETURN
    ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 57934 -j RETURN
    '';
    networking.firewall.extraStopCommands = ''
    ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 57934 -j RETURN || true
    ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 57934 -j RETURN || true
  ''; */

  system.stateVersion = "23.05";
}

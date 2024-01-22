{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../users/denis/user.nix
    ../../users/hypruser/user.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      trusted-users = ["root" "@wheel" "denis"];
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };
  };

  # Auto system update
  system.autoUpgrade.flake = ./../flake.nix;

  boot = {
    # Kernel
    kernelPackages = pkgs.linuxPackages_zen;
    kernel.sysctl = {"vm.swappiness" = 5;};

    # Fix black screen on a system with an integrated GPU
    kernelParams = ["pcie_aspm=off"];
    extraModulePackages = with config.boot.kernelPackages; [
      lenovo-legion-module
    ];

    # Bootloader
    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
        configurationLimit = 15;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  # Networking
  networking = {
    hostName = "epimetheus";
    networkmanager.enable = true;
    # if packets are still dropped, they will show up in dmesg
    firewall.logReversePathDrops = true;
  };

  # Services
  services = {
    #arbtt does not work with wayland
    #arbtt.enable = true;
    #arbtt.logFile = "/home/denis/.arbtt/capture.log";

    # Printing
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns = true;
      # for a WiFi printer
      openFirewall = true;
    };

    # Firmware
    fwupd.enable = true;

    smartd.enable = true;

    xserver = {
      # NVIDIA drivers are unfree.
      videoDrivers = ["nvidia"];

      # Enable the X11 windowing system.
      enable = true;

      # Enable the KDE Plasma Desktop Environment.
      desktopManager.plasma5 = {
        enable = true;
        notoPackage = pkgs.noto-fonts-cjk-sans;
      };

      # Configure keymap in X11

      layout = "de";
      xkbVariant = "nodeadkeys";

      # Enable automatic login for the user.
      displayManager = {
        sddm.enable = true;
        autoLogin.enable = false;
        autoLogin.user = "denis";
        sddm.theme = "sddm-chili";
        # Launch KDE in Wayland session
        defaultSession = "plasmawayland";
      };
    };

    # Enable flatpak
    flatpak.enable = true;
  };

  environment = {
    #ENV vars
    sessionVariables.NIXOS_OZONE_WL = "1";

    pathsToLink = ["/share/bash-completion"];

    plasma5.excludePackages = [
      pkgs.libsForQt5.oxygen
      pkgs.libsForQt5.elisa
      pkgs.libsForQt5.plasma-sdk
    ];

    systemPackages = with pkgs; [
      lenovo-legion
      virt-manager
      nixpkgs-fmt
      dracula-theme
      (pkgs.callPackage ../../modules/themes/sddm-chilli.nix {})
      wget
      vim
    ];
  };

  # NixOS configuration for Star Citizen requirements
  zramSwap.enable = true;
  boot.kernel.sysctl = {
    "vm.max_map_count" = 16777216;
    "fs.file-max" = 524288;
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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

    supportedLocales = [
      "C.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
      "en_GB.UTF-8/UTF-8"
      "de_DE.UTF-8/UTF-8"
    ];
  };

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
  hardware = {
    enableAllFirmware = true;

    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
        };
      };
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      prime.offload.enable = false;
    };

    opengl = {
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
  };

  system.stateVersion = "23.05";
}

{
  config,
  pkgs,
  inputs,
  _users,
  ...
}: let
  importUsers = userList: file:
    builtins.listToAttrs (builtins.map (u: {
        name = u;
        value = {imports = [../../users/${u}/${file}.nix];};
      })
      userList);

  createUsers = userList:
    builtins.listToAttrs (builtins.map (u: {
        name = u;
        value = {isNormalUser = true;};
      })
      userList);
in {
  imports =
    [
      ./hardware-configuration.nix
    ]
    ++ (builtins.map (u: ../../users/${u}/user.nix) _users);

  sops.defaultSopsFile = ../../secrets/example.yaml;
  sops.age.keyFile = "/home/denis/.config/sops/age/keys.txt";
  sops.secrets.wifi-home = {};

  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      trusted-users = ["root" "@wheel" "denis"];
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };
  };

  # Create all users using this machine
  users.users = createUsers _users;

  programs = {
    hyprland.enable = true;
    hyprland.xwayland.enable = true;
  };

  # Auto system update
  system.autoUpgrade.flake = ./../flake.nix;

  #Home-Manager config
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = importUsers _users "home";
    extraSpecialArgs = {
      inherit inputs;
      inherit (config.networking) hostName;
    };
  };

  boot = {
    # Kernel
    kernelPackages = pkgs.linuxPackages_zen;
    kernel.sysctl = {"vm.swappiness" = 5;};

    # Fix black screen on a system with an integrated GPU
    kernelParams = ["pcie_aspm=off" "nvidia.NVreg_PreserveVideoMemoryAllocations=1"];
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
      xkbOptions = "caps:swapescape";

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
    sessionVariables.MOZ_ENABLE_WAYLAND = "1";
    sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

    pathsToLink = ["/share/bash-completion"];

    plasma5.excludePackages = [
      pkgs.libsForQt5.oxygen
      pkgs.libsForQt5.elisa
      pkgs.libsForQt5.plasma-sdk
    ];

    systemPackages = with pkgs; [
      #need the qt5 thingys for sddm to work+
      qt6Packages.qt6ct
      qt6.qtwayland
      libsForQt5.breeze-icons
      libsForQt5.qt5.qtwayland
      libsForQt5.qt5.qtquickcontrols2
      libsForQt5.qt5.qtgraphicaleffects
      libsForQt5.qt5ct
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.polkit-kde-agent
      libsForQt5.polkit-qt

      lenovo-legion
      virt-manager
      nixpkgs-fmt
      dracula-theme
      (pkgs.callPackage ../../modules/themes/sddm-chilli.nix {})
      wget
      neovim
      git
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
  #console.keyMap = "de-latin1-nodeadkeys";
  console.useXkbConfig = true;

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
        xdg-desktop-portal-hyprland
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
      powerManagement.enable = true;
      prime.offload.enable = false;
      open = false;
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

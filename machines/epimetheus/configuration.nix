{
  config,
  pkgs,
  inputs,
  lib,
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

  sops = {
    defaultSopsFile = ../../secrets/example.yaml;
    age.keyFile = "/home/denis/.config/sops/age/keys.txt";
    #secrets.wifi-home = {};
  };

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
    hyprland = {
      enable = true;
      xwayland.enable = true;
      #package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };
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
    backupFileExtension = "backup";
  };

  boot = {
    # Kernel
    kernelPackages = pkgs.linuxPackages_zen;
    kernel.sysctl = {"vm.swappiness" = 5;};

    # Fix black screen on a system with an integrated GPU
    # kernelParams = ["pcie_aspm=off" "nvidia.NVreg_PreserveVideoMemoryAllocations=1"];
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
      nssmdns4 = true;
      # for a WiFi printer
      openFirewall = true;
    };

    # Firmware
    fwupd.enable = true;

    smartd.enable = true;

    xserver = {
      # NVIDIA drivers are unfree.
      videoDrivers = ["amdgpu" "nvidia"];

      # Enable the X11 windowing system.
      enable = true;

      # Configure keymap in X11
      xkb = {
        layout = "de";
        variant = "nodeadkeys";
        options = "caps:swapescape";
      };
    };

    # Enable the KDE Plasma Desktop Environment.
    desktopManager.plasma6 = {
      enable = true;
      enableQt5Integration = true;
      notoPackage = pkgs.noto-fonts-cjk-sans;
    };

    # Enable automatic login for the user.
    displayManager = {
      sddm.enable = true;
      autoLogin.enable = false;
      autoLogin.user = "denis";
      #sddm.theme = "sddm-chili";
      sddm.wayland.enable = true;
      # Launch KDE in Wayland session
      defaultSession = "plasma";
    };

    # Enable flatpak
    flatpak.enable = true;
  };

  environment = {
    #ENV vars
    sessionVariables = {
      #NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
    };

    pathsToLink = ["/share/bash-completion"];

    plasma6.excludePackages = [
      pkgs.kdePackages.oxygen
      pkgs.kdePackages.elisa
      pkgs.kdePackages.plasma-sdk
    ];

    systemPackages = with pkgs; [
      (pkgs.wrapOBS {
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-backgroundremoval
          obs-pipewire-audio-capture
        ];
      })
      glxinfo
      libva
      libva-utils
      #need the qt5 thingys for sddm to work+
      qt6Packages.qt6ct
      qt6.qtwayland
      kdePackages.breeze-icons
      kdePackages.qtwayland
      #libsForQt5.qtquickcontrols2
      #libsForQt5.qtgraphicaleffects
      #libsForQt5.qt5ct
      #libsForQt5.qtstyleplugin-kvantum
      kdePackages.polkit-kde-agent-1
      kdePackages.polkit-qt-1

      lenovo-legion
      virt-manager
      virtiofsd
      nixpkgs-fmt
      dracula-theme
      #(pkgs.callPackage ../../modules/themes/sddm-chilli.nix {})
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
  virtualisation.spiceUSBRedirection.enable = true;

  xdg = {
    portal = {
      enable = true;
      #gtkUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal
        xdg-desktop-portal-wlr
        xdg-desktop-portal-kde
        #xdg-desktop-portal-hyprland
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
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };

    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.production; # (installs 550)
      modesetting.enable = true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        amdgpuBusId = "PCI:6:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
      powerManagement.enable = true;
      powerManagement.finegrained = true;
      open = false;
      nvidiaSettings = false;
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
        amdvlk
      ];
    };
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.gamemode.enable = true;

  system.stateVersion = "23.05";
}

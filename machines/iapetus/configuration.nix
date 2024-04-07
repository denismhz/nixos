{
  config,
  lib,
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
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ]
    ++ (builtins.map (u: ../../users/${u}/user.nix) _users);

  security.sudo.extraRules = [
    {
      groups = ["wheel"];
      commands = [
        {
          command = "ALL";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.trusted-users = ["denis"];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Create all users using this machine
  users.users = createUsers _users;

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

  services = {
    openssh = {
      enable = true;
      settings.PermitRootLogin = "yes";
      settings.PasswordAuthentication = false;
    };
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns = true;
      # for a WiFi printer
      openFirewall = true;
    };
    resolved.enable = true;
    blueman.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    xserver = {
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
        sddm.theme = "sddm-sugar-dracula";
        # Launch KDE in Wayland session
      };
    };
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

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
    "electron-24.8.6"
  ];

  sops = {
    defaultSopsFile = ../../secrets/example.yaml;
    age.keyFile = "/home/denis/.config/sops/age/keys.txt";
    secrets.wifi-home = {};
  };

  # Enable networking
  networking = {
    hostName = "iapetus";
    #networkmanager.enable = true;
    firewall.logReversePathDrops = true;
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

  environment = {
    #ENV vars
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
    };

    pathsToLink = ["/share/bash-completion"];

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

      (pkgs.callPackage ../../modules/themes/sddm-theme.nix {})

      lenovo-legion
      virt-manager
      nixpkgs-fmt
      dracula-theme
      wget
      neovim
      git
    ];
  };

  xdg = {
    portal = {
      config.common.default = "*";
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-kde
      ];
    };
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["DejaVuSansMono"];})
    font-awesome
  ];

  hardware = {
    bluetooth.enable = true;
    opengl.enable = true;
  };

  programs = {
    hyprland.enable = true;
    hyprland.xwayland.enable = true;
    dconf.enable = true;
    noisetorch.enable = true;
  };

  # Configure console keymap
  console.useXkbConfig = true;
  # Configure console keymap
  console.keyMap = lib.mkForce "de-latin1-nodeadkeys";

  # Enable sound with pipewire.
  sound.enable = true;
  security.rtkit.enable = true;

  system.stateVersion = "23.05";
}

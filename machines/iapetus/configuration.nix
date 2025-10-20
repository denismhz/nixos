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
  # Auto system update
  system.autoUpgrade.flake = ./../flake.nix;

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
      nssmdns4 = true;
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
      sddm = {
        enable = true;
        #theme = "sddm-sugar-dracula";
        wayland.enable = true;
      };
      autoLogin.enable = false;
      autoLogin.user = "denis";
      # Launch KDE in Wayland session
      defaultSession = "plasma";
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "de_DE.UTF-8";
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
      kdePackages.breeze-icons
      kdePackages.qt5.qtwayland
      kdePackages.qt5.qtquickcontrols2
      kdePackages.qt5.qtgraphicaleffects
      kdePackages.qt5ct
      kdePackages.qtstyleplugin-kvantum
      kdePackages.polkit-kde-agent-1
      kdePackages.polkit-qt

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
    nerd-fonts.dejavusans-mono
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

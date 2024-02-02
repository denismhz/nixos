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
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ]
    ++ (builtins.map (u: ../../users/${u}/user.nix) _users);

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  networking = {
    hostName = "iapetus"; # Define your hostname.

    # Enable networking
    networkmanager.enable = true;
    networkmanager.dns = "systemd-resolved";
  };

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
    resolved.enable = true;
    blueman.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    xserver = {
      enable = true;
      # Configure keymap in X11

      layout = "de";
      xkbVariant = "nodeadkeys";
      displayManager = {
        sddm.enable = true;
        sddm.theme = "sddm-sugar-dracula";
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

  environment.systemPackages = with pkgs; [
    #need the qt5 thingys for sddm to work
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
    qt6.qtwayland
    (pkgs.callPackage ../../modules/themes/sddm-theme.nix {})
    (pkgs.callPackage ../../modules/themes/rofi-theme.nix {})
    vim
    wget
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-hyprland
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["DejaVuSansMono"];})
    font-awesome
  ];

  hardware = {
    bluetooth.enable = true;

    opengl.enable = true;

    pulseaudio.enable = false;
  };

  sound.enable = true;
  security.rtkit.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

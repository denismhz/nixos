{pkgs, ...}: {
  commandline_tools = with pkgs; [
    swaybg
    unixtools.quota
    povray
    zoom-us
    cups-kyodialog
    mono
    unstable.platformio
    orca-slicer
    freecad-wayland
    android-udev-rules
    wireshark
    sshfs
    usbutils
    haskellPackages.sixel
    davinci-resolve
    zip
    unrar
    # grimblast #Screenshot utility
    hledger
    libgnome-keyring
    lshw
    deploy-rs
    age
    libnotify
    lm_sensors
    # Hyprland
    pulseaudio
    #esphome
    jq
    bc
    socat
    lxqt.lxqt-policykit
    polkit
    playerctl
    pamixer
    nwg-look
    wlr-randr
    unstable.hyprpaper

    #Command line tools
    dig
    /*
    or
    */
    q #like dig but more
    mtr
    icdiff
    /*
    or
    */
    #delta in modules/home-manager/git.nix
    fd # A simple, fast and user-friendly alternative to find
    progress
    nmon
    fx # json viewer
    gping
    /*
    or
    */
    liboping
    /*
    or
    */
    ioping # ping your harddrive
    ncdu # Disk usage analyzer with an ncurses interface /*or duf */
    duf
    hyperfine #Command-line benchmarking tool
    procs #A modern replacement for ps written in Rust
    # thefuck #Magnificent app which corrects your previous console command
    up #Ultimate Plumber is a tool for writing Linux pipes with instant live preview
    bottom #A cross-platform graphical process/system monitor with a customizable interface
    nitch
  ];

  user_packages = with pkgs; [
    godot_4
    logseq
    obsidian
    discord
    foliate
    jellyfin-media-player
    libreoffice-qt6-fresh
    libva-utils
    libvdpau-va-gl
    lutris
    mongodb-compass
    neovim
    nextcloud-client
    nil
    #nixd
    nvidia-vaapi-driver
    pciutils
    r2modman
    # rnix-lsp unmaintained
    smartmontools
    telegram-desktop
    vaapiVdpau
    vdpauinfo
    vulkan-tools
    vulkan-validation-layers
    wineWowPackages.staging
    wl-clipboard
    xdg-utils
  ];

  kde_packages = with pkgs; [
    kdePackages.dolphin
    kdePackages.ark # Archive creation/extraction software
    kdePackages.colord-kde # https://git.manherz.de/denismhz/nixos.gitColor daemon
    kdePackages.gwenview # Image viewer
    #kaddressbook # Address Book
    kdePackages.merkuro # Calendar
    kdePackages.kate # Text editor
    kdePackages.kcalc # Calculator
    kdePackages.kde-cli-tools
    kdePackages.kdeplasma-addons
    # KDE Things
    kdePackages.kdialog # Dialogs from bash
    kdePackages.kgamma
    kdePackages.kmenuedit
    kdePackages.kolourpaint # Paint
    kdePackages.kompare # File diffs
    kdePackages.korganizer # Organizer
    kdePackages.kscreenlocker
    #kdePackages.kwayland-integration
    kdePackages.kwrited
    kdePackages.plasma-browser-integration
    kdePackages.bluedevil # Bluetooth Manager
    kdePackages.accounts-qt
    kdePackages.bluez-qt # Bluetooth libs
    kdePackages.flatpak-kcm # kde flatpak module
    #kdePackages.kaccounts-integration
    #kdePackages.kaccounts-providers
    kdePackages.kdeconnect-kde
    kdePackages.kdecoration
    kdePackages.kde-gtk-config
    kdePackages.kdenlive
    kdePackages.kio
    kdePackages.kio-extras
    #kdePackages.kirigami-addons
    #kdePackages.kmail-account-wizard
    #kdePackages.kmailtransport
    #kdePackages.kontactinterface
    kdePackages.kpipewire
    kdePackages.ksystemstats
    kdePackages.layer-shell-qt
    kdePackages.packagekit-qt
    kdePackages.plasma-browser-integration
    kdePackages.plasma-disks
    kdePackages.plasma-pa
    #libsForQt5.plasma-remotecontrollers
    kdePackages.plasma-systemmonitor
    kdePackages.polkit-kde-agent-1
    kdePackages.powerdevil
    kdePackages.syntax-highlighting
    kdePackages.systemsettings
    kdePackages.xdg-desktop-portal-kde
    #no need for video thumbs -- ffmpegthumbs -- # Dolphin video thumbnails
    kdePackages.skanlite # Scanning
    kdePackages.skanpage # Multi-Page Scanning
    kdePackages.spectacle # Screenshots
  ];
}

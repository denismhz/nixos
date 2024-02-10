{pkgs, ...}: {
  commandline_tools = with pkgs; [
    nwg-look
    swaybg
    wlr-randr
    leptosfmt
    #Command line tools
    dig
    /*
    or
    */
    q #like dig but more
    mtr
    ranger
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
    thefuck #Magnificent app which corrects your previous console command
    up #Ultimate Plumber is a tool for writing Linux pipes with instant live preview
    bottom #A cross-platform graphical process/system monitor with a customizable interface
    #bat #in home.nix
    nitch
  ];

  user_packages = with pkgs; [
    discord
    foliate
    jellyfin-media-player
    libreoffice-qt
    libva-utils
    libvdpau-va-gl
    lutris
    mongodb-compass
    neovim
    nextcloud-client
    nil
    nixd
    nvidia-vaapi-driver
    pciutils
    r2modman
    rnix-lsp
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
    ark # Archive creation/extraction software
    bluedevil # Bluetooth Manager
    colord-kde # https://git.manherz.de/denismhz/nixos.gitColor daemon
    dolphin # File manager
    gwenview # Image viewer
    #kaddressbook # Address Book
    kalendar # Calendar
    kate # Text editor
    kcalc # Calculator
    kde-cli-tools
    kdeplasma-addons
    # KDE Things
    kdialog # Dialogs from bash
    kgamma5
    kmenuedit
    kolourpaint # Paint
    kompare # File diffs
    korganizer # Organizer
    kscreenlocker
    kwayland-integration
    kwrited
    libsForQt5.accounts-qt
    libsForQt5.bluez-qt # Bluetooth libs
    libsForQt5.flatpak-kcm # kde flatpak module
    #libsForQt5.kaccounts-integration
    #libsForQt5.kaccounts-providers
    libsForQt5.kdeconnect-kde
    libsForQt5.kdecoration
    libsForQt5.kde-gtk-config
    libsForQt5.kdenlive
    #libsForQt5.kirigami-addons
    #libsForQt5.kmail-account-wizard
    #libsForQt5.kmailtransport
    #libsForQt5.kontactinterface
    libsForQt5.kpipewire
    libsForQt5.ksystemstats
    libsForQt5.layer-shell-qt
    libsForQt5.packagekit-qt
    libsForQt5.plasma-browser-integration
    libsForQt5.plasma-disks
    libsForQt5.plasma-pa
    libsForQt5.plasma-remotecontrollers
    libsForQt5.plasma-systemmonitor
    libsForQt5.polkit-kde-agent
    libsForQt5.powerdevil
    libsForQt5.syntax-highlighting
    libsForQt5.systemsettings
    libsForQt5.xdg-desktop-portal-kde
    #no need for video thumbs -- ffmpegthumbs -- # Dolphin video thumbnails
    skanlite # Scanning
    skanpage # Multi-Page Scanning
    spectacle # Screenshots
  ];
}

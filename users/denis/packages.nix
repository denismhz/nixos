{pkgs, ...}: {
  commandline_tools = with pkgs; [
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
    mongodb-compass

    neovim

    #language server
    nil
    nixd
    rnix-lsp

    wl-clipboard

    jellyfin-media-player
    nextcloud-client
    telegram-desktop
    discord
    libreoffice-qt
    foliate
    r2modman

    #Wine
    lutris
    wineWowPackages.staging

    # Other things
    nvidia-vaapi-driver
    vaapiVdpau
    vdpauinfo
    vulkan-validation-layers
    vulkan-tools
    libvdpau-va-gl
    pciutils
    smartmontools
    xdg-utils
    libva-utils
  ];

  kde_packages = with pkgs; [
    # KDE Things
    ark # Archive creation/extraction software

    #what the fuck is this???
    colord-kde # https://git.manherz.de/denismhz/nixos.gitColor daemon
    dolphin # File manager
    #no need for video thumbs -- ffmpegthumbs -- # Dolphin video thumbnails
    gwenview # Image viewer
    kalendar # Calendar
    kaddressbook # Address Book
    kate # Text editor
    kcalc # Calculator
    kdialog # Dialogs from bash
    kolourpaint # Paint
    kompare # File diffs
    korganizer # Organizer
    skanlite # Scanning
    skanpage # Multi-Page Scanning
    spectacle # Screenshots
    bluedevil # Bluetooth Manager
    libsForQt5.bluez-qt # Bluetooth libs

    libsForQt5.flatpak-kcm # kde flatpak module
    kde-cli-tools
    libsForQt5.kdecoration
    kdeplasma-addons
    kgamma5
    kmenuedit
    libsForQt5.kpipewire
    kscreenlocker
    libsForQt5.ksystemstats
    kwayland-integration
    kwrited
    libsForQt5.kdenlive
    libsForQt5.layer-shell-qt
    libsForQt5.kmail-account-wizard
    libsForQt5.kmailtransport
    libsForQt5.kontactinterface
    libsForQt5.accounts-qt
    libsForQt5.kaccounts-providers
    libsForQt5.kaccounts-integration
    libsForQt5.plasma-browser-integration
    libsForQt5.plasma-disks
    libsForQt5.plasma-pa
    libsForQt5.plasma-remotecontrollers
    libsForQt5.plasma-systemmonitor
    libsForQt5.polkit-kde-agent
    libsForQt5.powerdevil
    libsForQt5.systemsettings
    libsForQt5.xdg-desktop-portal-kde
    libsForQt5.packagekit-qt
    libsForQt5.kdeconnect-kde
    libsForQt5.kirigami-addons
    libsForQt5.syntax-highlighting
    libsForQt5.kde-gtk-config
  ];
}

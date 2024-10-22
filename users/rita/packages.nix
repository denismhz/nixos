{pkgs, ...}: {
  commandline_tools = with pkgs; [
    zip
    appimage-run
    unrar
    libgnome-keyring
    lshw
    age
    libnotify
    lm_sensors
    pulseaudio
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
    # thefuck #Magnificent app which corrects your previous console command
    up #Ultimate Plumber is a tool for writing Linux pipes with instant live preview
    bottom #A cross-platform graphical process/system monitor with a customizable interface
    nitch
  ];

  user_packages = with pkgs; [
    kdePackages.dolphin
    libreoffice-qt
    libva-utils
    libvdpau-va-gl
    neovim
    nextcloud-client
    pciutils
    r2modman
    vaapiVdpau
    vdpauinfo
    vulkan-tools
    vulkan-validation-layers
    wl-clipboard
    xdg-utils
  ];

  kde_packages = with pkgs; [
    ark # Archive creation/extraction software
    colord-kde # https://git.manherz.de/denismhz/nixos.gitColor daemon
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
    kdePackages.plasma-browser-integration
    kdePackages.bluedevil # Bluetooth Manager
    kdePackages.accounts-qt
    kdePackages.bluez-qt # Bluetooth libs
    kdePackages.flatpak-kcm # kde flatpak module
    kdePackages.kdeconnect-kde
    kdePackages.kdecoration
    kdePackages.kde-gtk-config
    kdePackages.kio
    kdePackages.kio-extras
    kdePackages.kpipewire
    kdePackages.ksystemstats
    kdePackages.layer-shell-qt
    kdePackages.packagekit-qt
    kdePackages.plasma-browser-integration
    kdePackages.plasma-disks
    kdePackages.plasma-pa
    kdePackages.plasma-systemmonitor
    kdePackages.polkit-kde-agent-1
    kdePackages.powerdevil
    kdePackages.syntax-highlighting
    kdePackages.systemsettings
    kdePackages.xdg-desktop-portal-kde
    skanlite # Scanning
    skanpage # Multi-Page Scanning
    spectacle # Screenshots
  ];
}

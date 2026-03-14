{pkgs, ...}: {
  commandline_tools = with pkgs; [
    unstable.mindustry-wayland
    unstable.esphome
    appimage-run
    jmtpfs
    age
    btop
    cups-kyodialog
    deploy-rs
    dig
    fd
    freecad-wayland
    fx
    gping
    haskellPackages.sixel
    icdiff
    ioping
    jq
    kdlfmt
    libgnome-keyring
    libnotify
    liboping
    lm_sensors
    lshw
    lxqt.lxqt-policykit
    mtr
    ncdu
    nil
    nitch
    nmon
    nwg-look
    pamixer
    playerctl
    polkit
    povray
    progress
    pulseaudio
    q
    socat
    sshfs
    swaybg
    unrar
    unstable.hyprpaper
    usbutils
    wlr-randr
    zip
  ];

  user_packages = with pkgs; [
    calibre
    discord
    foliate
    godot_4
    jellyfin-media-player
    libreoffice-qt6-fresh
    logseq
    lutris
    neovim
    nextcloud-client
    obsidian
    orca-slicer
    pciutils
    r2modman
    smartmontools
    telegram-desktop
    wineWowPackages.staging
    wireshark
    wl-clipboard
    xdg-utils
  ];

  kde_packages = with pkgs; [
    kdePackages.accounts-qt
    kdePackages.ark # Archive creation/extraction software
    kdePackages.bluedevil # Bluetooth Manager
    kdePackages.bluez-qt # Bluetooth libs
    kdePackages.colord-kde # https://git.manherz.de/denismhz/nixos.gitColor daemon
    kdePackages.dolphin
    kdePackages.flatpak-kcm # kde flatpak module
    kdePackages.gwenview # Image viewer
    kdePackages.kate # Text editor
    kdePackages.kcalc # Calculator
    kdePackages.kde-cli-tools
    kdePackages.kdeconnect-kde
    kdePackages.kdecoration
    kdePackages.kde-gtk-config
    kdePackages.kdenlive
    kdePackages.kdeplasma-addons
    kdePackages.kdialog # Dialogs from bash
    kdePackages.kgamma
    kdePackages.kio
    kdePackages.kio-extras
    kdePackages.kmenuedit
    kdePackages.kolourpaint # Paint
    kdePackages.kompare # File diffs
    kdePackages.korganizer # Organizer
    kdePackages.kpipewire
    kdePackages.kscreenlocker
    kdePackages.ksystemstats
    kdePackages.kwrited
    kdePackages.layer-shell-qt
    kdePackages.merkuro # Calendar
    kdePackages.packagekit-qt
    kdePackages.plasma-browser-integration
    kdePackages.plasma-browser-integration
    kdePackages.plasma-disks
    kdePackages.plasma-pa
    kdePackages.plasma-systemmonitor
    kdePackages.polkit-kde-agent-1
    kdePackages.powerdevil
    kdePackages.skanlite # Scanning
    kdePackages.skanpage # Multi-Page Scanning
    kdePackages.spectacle # Screenshots
    kdePackages.syntax-highlighting
    kdePackages.systemsettings
    kdePackages.xdg-desktop-portal-kde
  ];
}

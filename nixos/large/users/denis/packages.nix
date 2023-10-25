{ config, pkgs, unstable, ... }:
{
  user_packages = with pkgs; [

    gcc
    gdb

    jellyfin-media-player
    # i dont want to use whatsie with steam run :/
    # resolution shit <- but whatsapp-for-linux isnt working with x11
    (libsForQt5.callPackage ./home-manager/programs/whatsie.nix { })
    ripgrep
    bitwarden
    #need for grub ?
    os-prober
    nextcloud-client
    mongodb-compass
    pfetch
    telegram-desktop
    discord
    unstable.nixd
    libreoffice-qt
    rnix-lsp
    foliate
    logseq

    #package focalboard

    unstable.r2modman
    
    # Time Tracking
    #activitywatch
    haskellPackages.arbtt

    #Wine
    lutris
    wineWowPackages.stableFull
    wineWowPackages.staging
    wineWowPackages.fonts
    wineWowPackages.waylandFull
    dxvk

    vlc

    #qt do i even use this
    qt6.full

    # KDE Things
    akonadi # Storage service for KMail etc.
    libsForQt5.akonadi-mime
    libsForQt5.akonadi-notes
    libsForQt5.akonadiconsole
    libsForQt5.akonadi-search
    libsForQt5.akonadi-contacts
    libsForQt5.akonadi-calendar
    libsForQt5.akonadi-import-wizard
    libsForQt5.akonadi-calendar-tools
    libsForQt5.kio-gdrive
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
    #keditbookmarks # Bookmark edit in Konsole/Dolphin
    #kitinerary # Library for itinerary data
    #kmail # Mail client
    kolourpaint # Paint
    kompare # File diffs
    korganizer # Organizer
    skanlite # Scanning
    skanpage # Multi-Page Scanning
    spectacle # Screenshots
    bluedevil # Bluetooth Manager
    libsForQt5.bluez-qt # Bluetooth libs

    #remove breeze themes kinda doubled
    #breeze-gtk # gtk theme
    #breeze-qt5 # qt5 theme
    discover # flathub software center
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

    # Other things
    xdg-desktop-portal-gtk
    xdg-desktop-portal
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
}

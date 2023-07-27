{ config, pkgs, ... }:
{

  user_packages = with pkgs; [
    (libsForQt5.callPackage ./whatsie.nix {})
    oh-my-posh
    exa
    alacritty
    nextcloud-client
    neofetch
    discord
    nixd
    (vscode-with-extensions.override {
      vscode = vscodium;
      vscodeExtensions = with vscode-extensions; [
        jnoortheen.nix-ide
        arrterian.nix-env-selector
        mkhl.direnv
        ms-vscode-remote.remote-ssh
        yzhang.markdown-all-in-one
        pkief.material-icon-theme
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        /*{
          name = "remote-ssh-edit";
          publisher = "ms-vscode-remote";
          version = "0.47.2";
          sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
        }*/
      ];
    })
    tealdeer # tldr in rust
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
    colord-kde # Color daemon
    dolphin # File manager
    ffmpegthumbs # Dolphin video thumbnails
    gwenview # Image viewer
    kalendar # Calendar
    kaddressbook # Address Book
    kate # Text editor
    kcalc # Calculator
    kdialog # Dialogs from bash
    keditbookmarks # Bookmark edit in Konsole/Dolphin
    kitinerary # Library for itinerary data
    kmail # Mail client
    kolourpaint # Paint
    kompare # File diffs
    korganizer # Organizer
    skanlite # Scanning
    skanpage # Multi-Page Scanning
    spectacle # Screenshots
    bluedevil # Bluetooth Manager
    libsForQt5.bluez-qt # Bluetooth libs
    breeze-grub # grub theme
    breeze-gtk # gtk theme
    breeze-qt5 # qt5 theme
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
    nix-index
    xdg-utils
    libva-utils
    (librewolf.override { extraNativeMessagingHosts = [ libsForQt5.plasma-browser-integration ]; })
  ];
}

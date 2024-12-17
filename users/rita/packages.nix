{pkgs, ...}: {
  commandline_tools = with pkgs; [
    zip
    appimage-run
    unrar
    libgnome-keyring
    lshw
    age
    lxqt.lxqt-policykit
    polkit
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
    kalendar # Calendar
    kate # Text editor
    kcalc # Calculator
    kde-cli-tools
    kdeplasma-addons
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

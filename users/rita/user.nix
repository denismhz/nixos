{
  lib,
  pkgs,
  config,
  ...
}: let
  hostname = config.networking.hostName;
in {
  # Define a user account. Don't forget to set a password with  ^`^xpasswd ^`^y.
  # Initial definition of user account in machine configuration
  # extra settings here
  users.users.rita = {
    description = "Rita Manherz";
    extraGroups = ["wheel"];
    hashedPassword = "$6$jGbfUnAjTwJBPbJJ$7qH9mprLg5vtkqbOgmSHPX.Cnx9hwCcz/6cF8SWV9UgiGhqhh6SQfQZFxohKx4863vfDYDJdwZNlSs7taRxKb.";
  };

  networking.firewall = {
    allowedTCPPortRanges = [
      {
        #KDE Connect
        from = 1714;
        to = 1764;
      }
    ];
    # Firewall Ports for samba
    allowedTCPPorts = [
      5357 # samba
    ];
    allowedUDPPorts = [
      3702 # samba
    ];
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["DejaVuSansMono" "JetBrainsMono" "Iosevka"];})
    font-awesome
    comic-mono
  ];
}

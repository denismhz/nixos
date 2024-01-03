{
  description = "KDE Default Configuration";
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-23.11;
    unstable.url = github:nixos/nixpkgs/nixos-unstable;
    hyprland.url = "github:hyprwm/Hyprland";
    aithings.url = github:denismhz/flake/sd_webui;
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = github:nix-community/home-manager/release-23.11;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "https://git.manherz.de/tobias/nixos-hardware-fork/archive/master.tar.gz";
  };

  outputs =
    inputs@
    { self
    , nixpkgs
    , home-manager
    , ...
    }:
    let
      _users = {
        _denis = {
          denis.imports = [ ./users/denis/home.nix ];
        };
        _hypruser = {
          hypruser.imports = [ ./users/hypruser/home.nix ];
        };
      };
    in
    {
      # Lenovo Legion
      nixosConfigurations.epimetheus = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          inputs.nixos-hardware.nixosModules.lenovo-legion-16ach6h-hybrid
          ./machines/epimetheus/configuration.nix
          inputs.aithings.nixosModules.invokeai-nvidia
          inputs.aithings.nixosModules.a1111-nvidia
          home-manager.nixosModules.home-manager
          ({ config, ... }:
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users = nixpkgs.lib.mkMerge [_users._denis _users._hypruser];
              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit (config.networking) hostName;
              };
            })
        ];
      };

      # ASUS Zenbook
      nixosConfigurations.nixos-mini-denis = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.denis.imports = [
              inputs.hyprland.homeManagerModules.default
              ./users/denis/home.nix
            ];
          }
          ./machines/iapetus/configuration.nix
        ];
      };

      # Rpi 3B+
      nixosConfigurations.nixos-rpi-denis = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./machines/rpi/configuration.nix
        ];
      };
    };
}

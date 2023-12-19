{
  description = "KDE Default Configuration";
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-23.11;
    unstable.url = github:nixos/nixpkgs/nixos-unstable;
    aithings.url = github:denismhz/flake/sd_webui;

    home-manager = {
      url = github:nix-community/home-manager/release-23.11;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    plasma-manager.url = "github:pjones/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs =
  inputs@
  { self,
    nixpkgs,
    unstable,
    home-manager,
    nixos-hardware,
    ...
  }:
  {
    nixosConfigurations.epimetheus = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.aithings.nixosModules.invokeai-nvidia
        inputs.aithings.nixosModules.a1111-nvidia
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.denis.imports = [
            ./users/denis/home/home.nix
            inputs.plasma-manager.homeManagerModules.plasma-manager
          ];
        }
        #nixos-hardware.nixosModules.lenovo-legion-16ach6h-hybrid
        #cannot create directory 'root/lib/firmware/edid': Permission denied
        ./machines/large/configuration.nix
      ];
      specialArgs = {
        unstable = import unstable {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      };
    };

    nixosConfigurations.nixos-mini-denis = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.denis.imports = [
            inputs.hyprland.homeManagerModules.default
            ./machines/mini/home.nix
          ];
        }
        ./machines/mini/configuration.nix
      ];
      specialArgs = { unstable = unstable.legacyPackages.x86_64-linux; };
    };

    nixosConfigurations.nixos-rpi-denis = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./machines/rpi/configuration.nix
      ];
    };
  };
}

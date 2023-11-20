{
  description = "KDE Default Configuration";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-23.05;
    unstable.url = github:NixOS/nixpkgs/nixos-unstable;
    aithings.url = github:nixified-ai/flake;

    home-manager = {
      url = github:nix-community/home-manager/release-23.05;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    plasma-manager.url = "github:pjones/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs =
    inputs@
    { self
    , nixpkgs
    , unstable
    , home-manager
    , nixos-hardware
    , ...
    }:
  {
    nixosConfigurations.nixos-denis = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.aithings.nixosModules.invokeai-nvidia
        ./nixos/large/ai.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.denis.imports = [
              ./nixos/large/users/denis/home-manager/home.nix
              inputs.plasma-manager.homeManagerModules.plasma-manager
            ];
          }
          nixos-hardware.nixosModules.lenovo-legion-16ach6h-hybrid
          ./nixos/large/configuration.nix
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
              ./nixos/mini/home.nix
          ];
        }
      ./nixos/mini/configuration.nix
      ];
      specialArgs = { unstable = unstable.legacyPackages.x86_64-linux; };
    };

    nixosConfigurations.nixos-rpi-denis = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
      ./nixos/rpi/configuration.nix
      ];
    };
  };
}

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

    hyprland.url = "github:hyprwm/Hyprland";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
        ({config,...}:
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.denis.imports = [
            ./users/denis/home.nix
          ];
          home-manager.extraSpecialArgs =  {
          inherit inputs; 
          inherit (config.networking) hostName; 
          };
        })
        #nixos-hardware.nixosModules.lenovo-legion-16ach6h-hybrid
        #cannot create directory 'root/lib/firmware/edid': Permission denied
        ./machines/epimetheus/configuration.nix
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
            ./users/denis/home.nix
          ];
        }
        ./machines/iapetus/configuration.nix
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

{
  description = "KDE Default Configuration";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-23.05;
    unstable.url = github:NixOS/nixpkgs/nixos-unstable;

    darkmatter-grub-theme = {
      url = gitlab:VandalByte/darkmatter-grub-theme;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = github:nix-community/home-manager/release-23.05;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@
    { self
    , nixpkgs
    , unstable
    , darkmatter-grub-theme
    , home-manager
    , ...
    }:
    {
      nixosConfigurations.nixos-denis = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          darkmatter-grub-theme.nixosModule
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.denis = import ./nixos/users/denis/home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
          ./nixos/configuration.nix
        ];
        specialArgs = { unstable = unstable.legacyPackages.x86_64-linux; };
      };
    };
}

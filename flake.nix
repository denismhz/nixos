{
  description = "KDE Default Configuration";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-23.05;
    unstable.url = github:NixOS/nixpkgs/nixos-unstable;
    darkmatter-grub-theme = {
      url = gitlab:VandalByte/darkmatter-grub-theme;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, unstable, darkmatter-grub-theme, ... }:
    {
      nixosConfigurations.nixos-denis = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          darkmatter-grub-theme.nixosModule
          ./nixos/configuration.nix
        ];
        specialArgs = { unstable = unstable.legacyPackages.x86_64-linux; };
      };
    };
}

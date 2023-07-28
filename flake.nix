{
  description = "KDE Default Configuration";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-23.05;
    unstable.url = github:NixOS/nixpkgs/nixos-unstable;
  };

  outputs = { self, nixpkgs, unstable, ... }@attrs:
    {
      nixosConfigurations.nixos-denis = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./nixos/configuration.nix ];
        specialArgs = { unstable = unstable.legacyPackages.x86_64-linux; };
      };
    };
}

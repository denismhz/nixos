{
  description = "KDE Default Configuration";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs;
  };

  outputs = { self, nixpkgs }:
    let pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
    in {
      nixosConfigurations.nixos-denis = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./nixos/configuration.nix ];
      };
    };

  /*nixosConfigurations.nixos-denis = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./nixos/configuration.nix ];
    };*/

}

{
  description = "My machines";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    aithings.url = "github:denismhz/flake/sd_webui";
    nix-gaming.url = "github:fufexan/nix-gaming";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "https://git.manherz.de/tobias/nixos-hardware-fork/archive/master.tar.gz";
    neovim-flake.url = "github:jordanisaacs/neovim-flake";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    neovim-flake,
    ...
  }: let
    system = "x86_64-linux";

    configModule = {
      config = {
        vim = {
          theme.name = "dracula-nvim";
          useSystemClipboard = false;
          languages.sql.lsp.enable = false;
          tabline.nvimBufferline.enable = false;
          filetree.nvimTreeLua.enable = false;
        };
      };
    };

    baseNeovim = neovim-flake.packages.${system}.maximal;
    neovimExtended = baseNeovim.extendConfiguration {modules = [configModule];};

    nvim-overlay = _: _: {
      neovim = neovimExtended;
    };

    unstable-overlay = _: _: {
      unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
    };
  in {
    nixosConfigurations = {
      # Lenovo Legion
      epimetheus = let
        _users = ["denis" "hypruser"];
      in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {inherit inputs _users;};
          modules = [
            ./machines/epimetheus/configuration.nix
            inputs.nixos-hardware.nixosModules.lenovo-legion-16ach6h-hybrid
            inputs.aithings.nixosModules.invokeai-nvidia
            inputs.aithings.nixosModules.a1111-nvidia
            home-manager.nixosModules.home-manager
            {nixpkgs.overlays = [nvim-overlay unstable-overlay];}
          ];
        };

      # ASUS Zenbook
      nixos-mini-denis = let
        _users = ["denis" "hypruser"];
      in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {inherit inputs _users;};
          modules = [
            ./machines/iapetus/configuration.nix
            home-manager.nixosModules.home-manager
            {nixpkgs.overlays = [nvim-overlay unstable-overlay];}
          ];
        };

      # Rpi 3B+
      nixos-rpi-denis = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./machines/rpi/configuration.nix
        ];
      };
    };
  };
}

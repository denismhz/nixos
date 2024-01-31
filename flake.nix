{
  description = "KDE Default Configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
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
        };
      };
    };

    baseNeovim = neovim-flake.packages.${system}.maximal;
    neovimExtended = baseNeovim.extendConfiguration {modules = [configModule];};

    nvim-overlay = _: _: {
      neovim = neovimExtended;
    };

    _users = {
      _denis = {
        denis.imports = [./users/denis/home.nix];
      };
      _hypruser = {
        hypruser.imports = [
          ./users/hypruser/home.nix
          inputs.hyprland.homeManagerModules.default
        ];
      };
    };
  in {
    nixosConfigurations = {
      # Lenovo Legion
      epimetheus = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./machines/epimetheus/configuration.nix
          inputs.nixos-hardware.nixosModules.lenovo-legion-16ach6h-hybrid
          inputs.aithings.nixosModules.invokeai-nvidia
          inputs.aithings.nixosModules.a1111-nvidia
          home-manager.nixosModules.home-manager
          ({config, ...}: {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users = nixpkgs.lib.mkMerge [_users._denis _users._hypruser];
              extraSpecialArgs = {
                inherit inputs;
                inherit (config.networking) hostName;
              };
            };
          })
          {nixpkgs.overlays = [nvim-overlay];}
        ];
      };

      # ASUS Zenbook
      nixos-mini-denis = nixpkgs.lib.nixosSystem {
        inherit system;
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
      nixos-rpi-denis = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./machines/rpi/configuration.nix
        ];
      };
    };
  };
}

{
  description = "My machines";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-23-05.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    aithings.url = "git+file:///home/denis/repos/flake";
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
    neovim-flake.url = "github:denismhz/neovim-flake/leptosfmt";
    sops-nix.url = "github:Mic92/sops-nix";
    deploy-rs.url = "github:serokell/deploy-rs";
  };

  outputs = inputs @ {
    self,
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
      unstable = import inputs.nixpkgs-unstable {
        config.allowUnfree = true;
        inherit system;
      };
      old = import inputs.nixpkgs-23-05 {
        config.allowUnfree = true;
        inherit system;
      };
    };
  in {
    nixosConfigurations = {
      # Lenovo Legion
      epimetheus = let
        _users = ["denis" "hypruser"];
      in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs _users;
          };
          modules = [
            ./machines/epimetheus/configuration.nix
            inputs.nixos-hardware.nixosModules.lenovo-legion-16ach6h-hybrid #with nvidia prime
            #inputs.nixos-hardware.nixosModules.lenovo-legion-16ach6h-nvidia #without nvidia prime
            inputs.aithings.nixosModules.invokeai-nvidia
            inputs.aithings.nixosModules.a1111-nvidia
            inputs.sops-nix.nixosModules.sops
            home-manager.nixosModules.home-manager
            {
              nixpkgs.overlays = [
                nvim-overlay
                unstable-overlay
                (final: prev: {
                  obsidian-wayland = prev.obsidian.override {electron = final.electron_24;};
                })
              ];
            }
            (_: {
              nixpkgs.config.permittedInsecurePackages = [
                "nix-2.16.2"
                "electron-25.9.0"
                "electron-24.8.6"
                "nix-2.15.3"
              ];
            })
          ];
        };

      # ASUS Zenbook
      iapetus = let
        _users = ["denis"];
      in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {inherit inputs _users;};
          modules = [
            ./machines/iapetus/configuration.nix
            home-manager.nixosModules.home-manager
            inputs.sops-nix.nixosModules.sops
            {
              nixpkgs.overlays = [
                nvim-overlay
                unstable-overlay
                (final: prev: {
                  obsidian-wayland = prev.obsidian.override {electron = final.electron_24;};
                })
              ];
            }
            (_: {
              nixpkgs.config.permittedInsecurePackages = [
                "nix-2.16.2"
                "electron-25.9.0"
                "electron-24.8.6"
                "nix-2.15.3"
              ];
            })
          ];
        };

      # Rpi 3B+
      rpi3b = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          {nixpkgs.overlays = [nvim-overlay];}
          "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
          inputs.sops-nix.nixosModules.sops
          (_: {
            nixpkgs.hostPlatform = "aarch64-linux";
            nixpkgs.buildPlatform = "x86_64-linux";
            documentation.nixos.enable = false;
            boot.initrd.availableKernelModules = ["xhci_pci" "usbhid" "usb_storage"];
            nix.settings.trusted-users = ["@wheel"];
            sdImage = {
              compressImage = false;
              imageName = "rpi.img";
            };
          })
          ./machines/rpi/configuration.nix
        ];
      };
    };
    deploy.nodes = {
      iapetus = {
        hostname = "192.168.1.120";
        profiles.system = {
          sshUser = "denis";
          sshOpts = ["-A"];
          user = "root";
          path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.iapetus;
        };
      };
      rpi3b = {
        hostname = "192.168.1.140";
        profiles.system = {
          sshOpts = ["-t"];
          sshUser = "denis";
          user = "root";
          path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.rpi3b;
        };
      };
    };
    checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) inputs.deploy-rs.lib;
  };
}

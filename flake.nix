# Taken from: https://www.youtube.com/watch?v=rEovNpg7J0M
# Build system: sudo nixos-rebuild switch --flake ~/mysystem/#yoga
{
  description = "My basic system flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/Hyprland-Plugins";
      inputs.nixpkgs.follows = "hyprland";
    };

    nvf.url = "github:notashelf/nvf";
  };

  outputs = {
    self,
    nixpkgs,
    nixos-unstable,
    home-manager,
    nvf,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };

    unstablePkgs = import nixos-unstable {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  in {
    nixosConfigurations = {
      yoga = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs system;};

        modules = [
          ./hosts/yoga/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.dreezy = import ./hosts/yoga/home.nix;
              backupFileExtension = "backup"; #"hm-backup"; # Fixes problems where existing configs interfere with home-manager
              extraSpecialArgs = {inherit inputs unstablePkgs;};
            };
          }

          inputs.stylix.nixosModules.stylix
        ];
      };
    };
  };
}

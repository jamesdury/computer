{
  description = "NixOS configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    kickstart-nix-nvim.url = "github:nix-community/kickstart-nix.nvim";
  };

  outputs =
    inputs@{
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      ...
    }:
    {

      nixpkgs.config = {
        allowUnfree = true;
      };

      nixosConfigurations.molokoplus = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit nixpkgs;
          inherit nixpkgs-unstable;
          myLib = import ./lib { inherit (nixpkgs) lib; };
        };
        modules = [
          #./hosts/molokoplus/hardware-configuration.nix
          ./configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };
    };
}

{ lib, inputs, nixpkgs, self, user, sops-nix, ... }:
# This essentially extends the flake
# do hostname - lib.nixosSystem {} to define a config Make a subfolder for each config
# Build with nixos-rebuild --flake .#{configName} (I think)
let
  system = "aarch64-linux";
  pkgs = import nixpkgs {
    config = { allowUnfree = true; };
    inherit system;
  };

  lib = nixpkgs.lib;
in
{

  server = nixpkgs.lib.nixosSystem {
    # Laptop profile
    inherit system;

    modules = [

      ./configuration.nix # Default for graphical desktops

    ];
    specialArgs = { inherit inputs user; };
  };
}

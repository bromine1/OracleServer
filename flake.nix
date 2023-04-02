{
  description = "A useful config";

  nixConfig = {
    # allow building without passing flags on first run
    extra-experimental-features = "nix-command flakes";

    # Grab binaries faster from sources
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    http-connections = 0; #No limit on number of connections

    # nix store optimizations
    auto-optimise-store = true;

  };


  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";


    sops-nix.url = "github:Mic92/sops-nix";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
    #emacs-overlay = {
    #  url = "github:nix-community/emacs-overlay";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};


    nil = { url = "github:oxalica/nil"; };
  };

  outputs =
    { self
    , nixpkgs
    , sops-nix
    , home-manager
    , nix-doom-emacs
    , neovim-nightly-overlay
    , nil #gets latest version of nil
    , ...
    }@inputs:

    let

      system = "aarch64-linux";

      #nixpkgs.config.allowUnfree = true;
      pkgs = nixpkgs.legacyPackages.${system};
      user = "opc";
      overlays = [ inputs.neovim-nightly-overlay.overlay ];
    in
    {
      nixosConfigurations = import ./hosts {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs user self sops-nix system;
        specialArgs.inputs = inputs;
      }; # Imports ./hosts/default.nix

      homeConfigurations = {
        nixpkgs.overlays = overlays;

        Setup = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };

          modules = [
            nix-doom-emacs.hmModule
            ./home/home.nix
          ];

          extraSpecialArgs = {
            inherit self;
          };

        };


      };
    };

}


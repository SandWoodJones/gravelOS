{
  description = "GravelOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "path:/home/swj/projects/nixpkgs";

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-needsreboot = {
      url = "github:thefossguy/nixos-needsreboot";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    base16.url = "github:SenchoPens/base16.nix";
    tt-schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };
    base16-helix = {
      url = "github:tinted-theming/base16-helix";
      flake = false;
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    openmw-nix = {
      url = "git+https://codeberg.org/PopeRigby/openmw-nix.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    let
      lib = inputs.snowfall-lib.mkLib {
        inherit inputs;
        src = ./.; # flake root directory

        snowfall = {
          namespace = "gravelOS";
          meta = {
            name = "gravelOS";
            title = "Gravel OS";
          };
        };
      };
    in
    lib.mkFlake {
      channels-config.allowUnfree = true;

      systems.modules.nixos = with inputs; [
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            backupFileExtension = "hm-backup";
            sharedModules = [
              sops-nix.homeManagerModules.sops
              base16.homeManagerModule
            ];
          };
        }

        sops-nix.nixosModules.sops

        base16.nixosModule
        nix-index-database.nixosModules.nix-index
        { }
      ];

      outputs-builder = channels: {
        formatter = channels.nixpkgs.nixfmt-tree;
      };
    };
}

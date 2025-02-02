{
  description = "SandWood's NixOS system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    # nixpkgs.url = "path:/home/swj/projects/nixpkgs";
    snowfall-lib = { url = "github:snowfallorg/lib"; inputs.nixpkgs.follows = "nixpkgs"; };
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    nix-index-database = { url = "github:nix-community/nix-index-database"; inputs.nixpkgs.follows = "nixpkgs"; };

    hyprland.url = "github:hyprwm/Hyprland";
    nixos-needsreboot = { url = "github:thefossguy/nixos-needsreboot"; inputs.nixpkgs.follows = "nixpkgs"; };

    openmw-nix = { url = "git+https://codeberg.org/PopeRigby/openmw-nix.git"; inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs = inputs:
    let lib = inputs.snowfall-lib.mkLib {
      inherit inputs;
      src = ./.; # flake root directory

      snowfall = {
        namespace = "gravelOS";
        meta = { name = "gravelOS"; title = "Gravel OS"; };
      };
    };

    in lib.mkFlake {
      channels-config.allowUnfree = true;

      systems.modules.nixos = with inputs; [
        home-manager.nixosModules.home-manager { home-manager.backupFileExtension = "hm-backup"; }
        nix-index-database.nixosModules.nix-index {}
      ];
    };
}

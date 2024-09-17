{
  description = "SandWood's NixOS system.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
        home-manager.nixosModules.home-manager
      ];
    };
}

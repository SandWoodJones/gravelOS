{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    systems.url = "github:nix-systems/default";
    rust-flake = {
      url = "github:juspay/rust-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;
      imports = with inputs; [
        rust-flake.flakeModules.default
        rust-flake.flakeModules.nixpkgs
      ];

      perSystem =
        {
          pkgs,
          lib,
          self',
          ...
        }:
        let
          projectName = (fromTOML (builtins.readFile ./Cargo.toml)).package.name;
        in
        {
          rust-project.crates."${projectName}".crane.args = {
            buildInputs = lib.optionals pkgs.stdenv.isDarwin [ pkgs.darwin.apple_sdk.frameworks.IOKit ];
          };
          packages.default = self'.packages."${projectName}";

          devShells.default =
            pkgs.mkShell.override { stdenv = pkgs.stdenvAdapters.useMoldLinker pkgs.stdenv; }
              {
                name = projectName;
                inputsFrom = [ self'.devShells.rust ];
                packages = with pkgs; [
                  bacon
                ];

                RUSTFLAGS = "-C link-arg=-fuse-ld=mold";
              };
        };
    };
}

{ openmw-nix, lib, ... }: final: prev: {
  openmw-validator = openmw-nix.packages.${final.system}.openmw-validator.overrideAttrs (old: rec {
    version = "1.13";
    src = prev.fetchFromGitLab {
      owner = "modding-openmw";
      repo = old.pname;
      rev = version;
      hash = "sha256-MCaIT2u4zcqqmdsYhzXkkK9B/sDv8pdsRnZPj8tCT2s=";
    };

    vendorHash = "sha256-x4n07zJj8M8mraMNMbtGwe/EBzzGVTcK7mrfi9KFips=";
  });
}

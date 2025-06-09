{
  openmw-nix,
  ...
}:
final: prev: {
  inherit (openmw-nix.packages.${final.system}) delta-plugin;

  openmw-validator = openmw-nix.packages.${final.system}.openmw-validator.overrideAttrs (old: rec {
    version = "1.14";
    src = prev.fetchFromGitLab {
      owner = "modding-openmw";
      repo = old.pname;
      rev = version;
      hash = "sha256-uA6BZfbOIFg3mLQaTAQ7tx6J0L9x2CeTJwxZWWO/PIg=";
    };

    vendorHash = "sha256-x4n07zJj8M8mraMNMbtGwe/EBzzGVTcK7mrfi9KFips=";
  });
}

# TODO: change to standard nixpkgs format

{ buildDotnetModule, fetchFromGitHub, ... }: buildDotnetModule rec {
  pname = "TES3Merge";
  version = "0.11";

  src = (fetchFromGitHub {
    owner = "NullCascade";
    repo = pname;
    rev = version;
    hash = "sha256-KcA73NnzDI99ZNSXV2ZIdNTIDU33UsRAkl5l1Z9WFqo=";
    fetchSubmodules = true;
  }).overrideAttrs {
    GIT_CONFIG_COUNT = 1;
    GIT_CONFIG_KEY_0 = "url.https://github.com/.insteadOf";
    GIT_CONFIG_VALUE_0 = "git@github.com:";
  };
  
  nugetDeps = ./deps.nix;

  meta = {
    description = "Object merge utility for The Elder Scrolls 3: Morrowind.";
  };
}

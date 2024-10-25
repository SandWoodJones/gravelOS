{ mkShell, pkgs, ... }: mkShell {
  NIX_CONFIG = "experimental-features = nix-command flakes";
  packages = with pkgs; [
    git
    helix
  ];
}

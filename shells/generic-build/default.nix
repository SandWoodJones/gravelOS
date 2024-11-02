{ mkShell, pkgs, ... }: mkShell {
  packages = with pkgs; [
    python3
    gcc
  ];
}

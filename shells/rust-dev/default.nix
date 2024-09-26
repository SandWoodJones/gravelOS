{ mkShell, pkgs, ... }: mkShell {
  packages = with pkgs; [
    (fenix.stable.toolchain)
  ];
}

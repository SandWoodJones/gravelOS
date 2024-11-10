{ mkShell, pkgs, ... }: mkShell {
  packages = with pkgs; [
      tes3cmd
      gravelOS.t3t
  ];
}

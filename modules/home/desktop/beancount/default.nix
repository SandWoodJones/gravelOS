{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.cli.beancount;

  beancountEnv = pkgs.python3.withPackages (
    ps: with ps; [
      beancount
      fava
      beancount-periodic
    ]
  );

  beancountCustom = pkgs.runCommand "beancount-custom" { } ''
    mkdir -p $out/bin
    ln -s ${beancountEnv}/bin/bean-* $out/bin/
    ln -s ${beancountEnv}/bin/fava $out/bin/
  '';
in
{
  options.gravelOS.cli.beancount = {
    enable = lib.mkEnableOption "beancount and fava";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ beancountCustom ];
  };
}

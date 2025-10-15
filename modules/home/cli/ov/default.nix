# TODO: finish translating config.yaml, make a settings option with pkgs.formats.yaml

{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.cli.ov;
in
{
  options.gravelOS.cli.ov = {
    enable = lib.gravelOS.mkEnableDefault "ov and set it as the default pager";
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = [ pkgs.ov ];
      file."${config.xdg.configHome}/ov/config.yaml".source = ./config.yaml;
      sessionVariables = {
        PAGER = lib.getExe pkgs.ov;
        MANPAGER = "${lib.getExe pkgs.ov} --section-delimiter '^[^\\s]' --section-header";
      };
    };

    programs = {
      git.settings.pager = {
        show = "delta --pager='ov --header 3'";
        diff = "delta --features ov-diff";
        log = "delta --features ov-log";
      };

      delta.options = {
        file-style = "yellow"; # TODO: remove this after theming delta and ov
        ov-diff.pager = "ov --section-delimiter '^(commit|added:|removed:|renamed:|Δ)' --section-header --pattern '•'";
        ov-log.pager = "ov --section-delimiter '^commit' --section-header-num 3";
      };
    };
  };
}

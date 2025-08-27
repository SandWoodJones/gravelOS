# TODO: finish configuring

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
    enable = lib.mkEnableOption "the ov pager";
    default.enable = lib.mkOption {
      default = true;
      example = false;
      description = "Whether to set ov as the default pager.";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = [ pkgs.ov ];
      file."${config.xdg.configHome}/ov/config.yaml".source = ./config.yaml;
      sessionVariables = lib.mkIf cfg.default.enable {
        PAGER = lib.getExe pkgs.ov;
        MANPAGER = "${lib.getExe pkgs.ov} --section-delimiter '^[^\s]' --section-header";
      };
    };

    programs.git = lib.mkIf (cfg.default.enable && config.gravelOS.cli.git.delta.enable) {
      extraConfig.pager = {
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

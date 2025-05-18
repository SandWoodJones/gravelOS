{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.system.services.nh;
in
{
  options.gravelOS.system.services.nh = {
    clean = {
      enable = lib.mkEnableOption "periodic garbage collection with nh.";
      keep = lib.mkOption {
        default = 10;
        description = "Minimum number of generations that nh clean should keep.";
        type = lib.types.ints.unsigned;
      };
      keepSince = lib.mkOption {
        default = "10d";
        example = "1h";
        description = "Minimum age of gcroots and generations that nh clean should keep.";
        type = lib.types.strMatching "[0-9]+[a-zA-Z]";
      };
    };
  };

  config = lib.mkIf cfg.clean.enable {
    programs.nh = {
      clean = lib.mkIf cfg.clean.enable {
        enable = true;
        extraArgs = "--keep ${builtins.toString cfg.clean.keep} --keep-since ${cfg.clean.keepSince}";
      };
    };
  };
}

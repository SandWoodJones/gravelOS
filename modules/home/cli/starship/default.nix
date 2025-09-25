{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.cli.starship;

  mergePresets =
    settings:
    let
      presetAttrs = map (
        preset:
        builtins.fromTOML (
          builtins.readFile "${config.programs.starship.package}/share/starship/presets/${preset}.toml"
        )
      ) cfg.presets;
      allSettings = presetAttrs ++ [ settings ];
    in
    lib.foldl' lib.recursiveUpdate { } allSettings;
in
{
  options.gravelOS.cli.starship = {
    enable = lib.mkEnableOption "Starship as the default prompt";
    presets = lib.mkOption {
      default = [ "nerd-font-symbols" ];
      example = [ "no-nerd-font" ];
      description = "Presets files to be merged with settings.";
      type = lib.types.listOf lib.types.str;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;

      settings = mergePresets {
        add_newline = true;
      };
    };
  };
}

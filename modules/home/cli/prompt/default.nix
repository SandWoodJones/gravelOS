{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.cli.prompt;

  starshipMergePresets =
    settings:
    let
      presetAttrs = map (
        preset:
        builtins.fromTOML (
          builtins.readFile "${config.programs.starship.package}/share/starship/presets/${preset}.toml"
        )
      ) cfg.starship.presets;
      allSettings = presetAttrs ++ [ settings ];
    in
    lib.foldl' lib.recursiveUpdate { } allSettings;
in
{
  options.gravelOS.cli.prompt = {
    newLine.enable = lib.gravelOS.mkEnableDefault "new lines between commands";
    starship = {
      enable = lib.gravelOS.mkEnableDefault "Starship as the default prompt";
      presets = lib.mkOption {
        default = [ "nerd-font-symbols" ];
        example = [ "no-nerd-font" ];
        description = "Presets files to be merged with settings.";
        type = lib.types.listOf lib.types.str;
      };
    };
  };

  config = {
    programs = {
      zsh = lib.mkIf cfg.newLine.enable {
        initContent = ''precmd() { precmd() { echo "" } }'';
        shellAliases.clear = "precmd() { precmd() { echo } } && clear";
      };

      starship = lib.mkIf cfg.starship.enable {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;

        settings = starshipMergePresets {
          add_newline = false;
        };
      };
    };
  };
}

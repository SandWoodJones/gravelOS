{
  lib,
  config,
}:
{
  # starshipMergePresets :: attrset -> attrset
  # arguments:
  #   settings: Starship configuration to apply
  # Merges multiple Starship prompt presets with the given custom settings
  starshipMergePresets =
    settings:
    let
      presetAttrs = map (
        preset:
        fromTOML (
          builtins.readFile "${config.programs.starship.package}/share/starship/presets/${preset}.toml"
        )
      ) config.gravelOS.cli.prompt.starship.presets;
      allSettings = presetAttrs ++ [ settings ];
    in
    lib.foldl' lib.recursiveUpdate { } allSettings;

  # promptGradient :: string -> string -> string -> attrset
  # arguments:
  #   start: hex color string for the start of both gradients
  #   end1: hex color string for the end of the first gradient
  #   end2: hex color string for the end of the second gradient
  # Generates 2 related 6-step color gradients from a shared start color to 2 different colors.
  promptGradient =
    start: end1: end2:
    with lib.gravelOS.color.lab;
    let
      inherit (lib.gravelOS) lerp;

      lab_start = hex2lab start;
      lab_end1 = hex2lab end1;
      lab_end2 = hex2lab end2;

      midpoint = lerp lab_end1 lab_end2 0.5;
      step1 = lerp lab_start midpoint 0.2;
      step2 = lerp lab_start midpoint 0.4;

      listToSet =
        colorList:
        builtins.listToAttrs (
          builtins.genList (i: {
            name = "c${toString (i + 3)}";
            value = builtins.elemAt colorList i;
          }) 3
        );

      compute =
        target:
        let
          step3 = lerp step2 target (1.0 / 3.0);
          step4 = lerp step2 target (2.0 / 3.0);
          colors = [
            step3
            step4
            target
          ];
        in
        listToSet (map lab2hex colors);
    in
    {
      c0 = start;
      c1 = lab2hex step1;
      c2 = lab2hex step2;
      grad1 = compute lab_end1;
      grad2 = compute lab_end2;
    };
}

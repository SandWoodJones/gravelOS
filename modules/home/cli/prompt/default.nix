{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.cli.prompt;
  utils = import ./utils.nix { inherit lib config; };
  promptGradient = with config.scheme.withHashtag; utils.promptGradient base0E base0B base08;
in
{
  options.gravelOS.cli.prompt = {
    new-line.enable = lib.gravelOS.mkEnableDefault "new lines between commands";
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
      fish.interactiveShellInit =
        lib.mkIf cfg.new-line.enable # fish
          ''
            function new_line --on-event fish_postexec
              set -l cmd (string trim -- "$argv[1]")
              if not string match -q -- "clear*" "$cmd"
                echo
              end
            end
          '';

      starship = lib.mkIf cfg.starship.enable {
        enable = true;

        settings = utils.starshipMergePresets {
          add_newline = false;
          format = ''
            [╔](${promptGradient.c2})[╸](${promptGradient.c1})$username@$hostname $directory
            $character
          '';

          username = {
            show_always = true;
            format = "[$user]($style)";
            style_user = "${promptGradient.c0} bold";
            style_root = "${promptGradient.c0} bold underline";
          };

          hostname = {
            ssh_only = false;
            format = "[$ssh_symbol$hostname]($style)";
          };

          character = {
            success_symbol = "[╚](${promptGradient.grad1.c3})[╸](${promptGradient.grad1.c4})[\\$](${promptGradient.grad1.c5} bold)";
            error_symbol = "[╚](${promptGradient.grad2.c3})[╸](${promptGradient.grad2.c4})[X](${promptGradient.grad2.c5} bold)";
          };
        };
      };
    };
  };
}

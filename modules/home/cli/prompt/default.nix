{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.cli.prompt;
  utils = import ./utils.nix { inherit lib config; };
  promptGradient = with config.scheme.withHashtag; utils.promptGradient base0E base0B base08;

  tomlFormat = pkgs.formats.toml { };
  transientConfigPath = tomlFormat.generate "starship_transient_config.toml" cfg.starship.transience.settings;
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
      transience = {
        enable = lib.gravelOS.mkEnableDefault "replacing old prompts with a simplified version, defined by the `starship_transient_prompt_func` fish function";
        settings = lib.mkOption {
          default = { };
          example = {
            character = {
              success_symbol = "[➜](bold green) ";
              error_symbol = "[✗](bold red) ";
            };
          };
          description = "The starship configuration used for transient prompts.";
          inherit (tomlFormat) type;
        };
      };
    };
  };

  config = {
    gravelOS.cli.prompt.starship.transience.settings = {
      character = {
        success_symbol = "[\\$](${promptGradient.grad1.c5} dimmed)";
        error_symbol = "[X](${promptGradient.grad2.c5} bold)";
      };
      time = with config.scheme.withHashtag; {
        disabled = false;
        format = "[\\[](${base03} dimmed)[$time]($style)[\\]](${base03} dimmed)";
        style = "${base04} dimmed";
      };
    };

    programs = {
      fish = {
        interactiveShellInit =
          lib.mkIf cfg.new-line.enable # fish
            ''
              function new_line --on-event fish_postexec
                set -l cmd (string trim -- "$argv[1]")
                if not string match -q -- "clear*" "$cmd"
                  echo
                end
              end
            '';

        functions = lib.mkIf cfg.starship.transience.enable {
          starship_transient_prompt_func = # fish
            ''
              if not test -z (commandline -p)
                printf '\033[1A'
              end
              set -lx STARSHIP_CONFIG "${transientConfigPath}"
              starship module character
            '';
          starship_transient_rprompt_func = # fish
            ''
              set -lx STARSHIP_CONFIG "${transientConfigPath}"
              starship module time
            '';
        };
      };

      starship = lib.mkIf cfg.starship.enable {
        enable = true;
        enableTransience = cfg.starship.transience.enable;

        settings = with config.scheme.withHashtag; utils.starshipMergePresets {
          add_newline = false;
          format = ''
            [╔](${promptGradient.c2})[╸](${promptGradient.c1})$username@$hostname $directory$direnv
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
            style = "${base14} bold";
          };

          character = {
            success_symbol = "[╚](${promptGradient.grad1.c3})[╸](${promptGradient.grad1.c4})[\\$](${promptGradient.grad1.c5} bold)";
            error_symbol = "[╚](${promptGradient.grad2.c3})[╸](${promptGradient.grad2.c4})[X](${promptGradient.grad2.c5} bold)";
          };

          directory = {
            style = "${base0C} bold";
            read_only_style = base08;
            truncation_symbol = "../";
          };

          direnv = {
            disabled = false;
            format = "[$symbol$allowed]($style)";
            symbol = " ";
            allowed_msg = "";
            not_allowed_msg = "/ ";
            denied_msg = "/ ";
          };
        };
      };
    };
  };
}

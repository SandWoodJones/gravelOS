# TODO: configure helix more
# TODO: make and use an edited monokai theme

{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.cli.helix;
in
{
  options.gravelOS.cli.helix = {
    enable = lib.mkEnableOption "helix and set it as the default text editor";
  };

  config = lib.mkIf cfg.enable {
    programs.helix = {
      enable = true;
      defaultEditor = true;

      themes.${config.scheme.slug} = builtins.readFile (
        config.scheme { template = builtins.readFile ./base16-template.mustache; }
      );

      settings = {
        theme = "${config.scheme.slug}";
        editor = {
          auto-format = false;
          smart-tab.enable = false;
          color-modes = true;
          bufferline = "multiple";
          cursor-shape.insert = "bar";

          lsp.auto-signature-help = false;

          statusline.center = [ "version-control" ];
          statusline.right = [
            "diagnostics"
            "file-type"
            "selections"
            "register"
            "position"
            "file-encoding"
          ];
        };

        keys = {
          normal = {
            C-x = ":toggle lsp.auto-signature-help";
          };
        };
      };

      languages = {
        language = [
          {
            name = "nix";
            formatter = {
              command = lib.getExe pkgs.nixfmt;
            };
          }

          {
            name = "hyprlang";
            file-types = [ { glob = "hypr*.conf"; } ];
          }
        ];
      };
    };
  };
}

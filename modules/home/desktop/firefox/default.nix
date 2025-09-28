{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.desktop.firefox;
in
{
  imports = [
    ./policies.nix
    ./searchEngines.nix
  ];

  options.gravelOS.desktop.firefox = {
    enable = lib.mkEnableOption "Firefox";
    pdfDefault.enable = lib.mkOption {
      default = false;
      example = true;
      description = "Whether to set Firefox as the default PDF file opener.";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;

      profiles.default = {
        containersForce = true;
        userChrome = builtins.readFile ./userChrome.css;

        settings = {
          "apz.overscroll.enabled" = false;
          "font.name.sans-serif.x-western" = "NotoSans Nerd Font";
          "font.name.serif.x-western" = "NotoSerif Nerd Font";
          "reader.parse-on-load.enabled" = false;
        };
      };
    };
  };
}

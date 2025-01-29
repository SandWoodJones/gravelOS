{ pkgs, lib, config, ... }:
let
  cfg = config.gravelOS.firefox;
in {
  options.gravelOS.firefox = {
    enable = lib.mkEnableOption "firefox";
    enableConfig = lib.mkOption {
      default = false;
      example = true;
      description = "Whether to enable gravelOS's firefox configuration.";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable {
    xdg.mimeApps.defaultApplications = lib.mkIf config.gravelOS.xdg.enable { "application/pdf" = [ "firefox.desktop" ]; };

    programs.firefox = {
      enable = true;

      policies = lib.mkIf cfg.enableConfig (import ./policies.nix);

      profiles.default = lib.mkIf cfg.enableConfig {
        containersForce = true;
        userChrome = builtins.readFile ./userChrome.css;

        search = {
          force = true;
          default = "Google";

          order = [ "YouTube" "Nix Packages" "NixOS Options" "Home Manager Options" "Noogle" ];
          engines = import ./engines.nix { inherit pkgs; };
        };

        settings = {          
          "apz.overscroll.enabled" = false;
          "font.name.sans-serif.x-western" = "NotoSans Nerd Font";
          "font.name.serif.x-western" = "NotoSerif Nerd Font";
        };
      };
    }; 
  };
}

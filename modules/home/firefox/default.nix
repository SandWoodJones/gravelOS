{ pkgs, lib, config, ... }:
let
  cfg = config.gravelOS.firefox;
in {
  options.gravelOS.firefox = {
    enable = lib.mkEnableOption "firefox";
    enableConfig = lib.mkOption {
      default = false;
      example = true;
      description = "Enable gravelOS' firefox configuration.";
      type = lib.types.bool;
    };
  };

  config = {
    programs.firefox = lib.mkIf cfg.enable {
      enable = true;

      policies = lib.mkIf cfg.enableConfig (import ./policies.nix);

      profiles.default = lib.mkIf cfg.enableConfig {
        containersForce = true;
        userChrome = builtins.readFile ./userChrome.css;

        search = {
          force = true;
          default = "Google";

          order = [ "YouTube" "Nix Packages" "NixOS Options" "Home Manager Options" ];
          engines = import ./engines.nix { inherit pkgs; };
        };
      };
    }; 
  };
}

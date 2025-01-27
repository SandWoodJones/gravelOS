{ pkgs, lib, config, ... }:
let
  cfg = config.gravelOS.kde;
in {
  options.gravelOS.kde.plasma = {
    enable = lib.mkOption {
      default = false;
      example = true;
      description = "Whether to enable the Plasma KDE desktop environment";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.plasma.enable {
    assertions = [{ assertion = config.gravelOS.display.enable; message = "you must have graphical display support enabled to use Plasma"; }];

    services.desktopManager.plasma6.enable = true;

    environment.systemPackages = [ pkgs.kdePackages.ksystemlog ];
  };
}

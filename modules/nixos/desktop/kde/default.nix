# TODO: stop using plasma entirely
# TODO: keep using dolphin maybe https://wiki.nixos.org/wiki/Dolphin

{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.desktop.kde;
in
{
  options.gravelOS.desktop.kde = {
    enable = lib.mkEnableOption "KDE Plasma.";
  };

  config = lib.mkIf cfg.enable {
    services.desktopManager.plasma6.enable = true;

    environment.systemPackages = [ pkgs.kdePackages.ksystemlog ];
  };
}

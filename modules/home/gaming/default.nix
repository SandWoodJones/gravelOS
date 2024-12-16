{ lib, config, pkgs, ... }: lib.mkIf config.gravelOS.desktop.gaming.enable {
  home.packages = with pkgs; [
    mangohud
    r2modman
  ];

  home.sessionVariables.WINEPREFIX = "${config.xdg.dataHome}/wine";
}

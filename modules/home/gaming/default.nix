{ lib, config, pkgs, ... }: lib.mkIf config.gravelOS.desktop.gaming.enable {
  home.packages = with pkgs; [
    mangohud
  ];

  home.sessionVariables.WINEPREFIX = "${config.xdg.dataHome}/wine";
}

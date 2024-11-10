{ osConfig, lib, pkgs, ... }: lib.mkIf osConfig.gravelOS.desktop.gaming.enable {
  home.packages = with pkgs; [
    mangohud
  ];
}

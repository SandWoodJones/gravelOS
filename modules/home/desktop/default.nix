{ config, lib, osConfig, pkgs, ... }: {
  config = lib.mkIf osConfig.gravelOS.desktop.enable {
    home.packages = with pkgs; [
      stremio
      telegram-desktop
      vesktop
      spotify
    ];
  };
}

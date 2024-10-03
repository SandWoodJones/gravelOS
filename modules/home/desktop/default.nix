{ config, lib, osConfig, pkgs, ... }: {
  config = lib.mkIf osConfig.gravelOS.desktop.enable {
    home.packages = with pkgs; [
      stremio spotify
      telegram-desktop vesktop
      obsidian
    ];
  };
}

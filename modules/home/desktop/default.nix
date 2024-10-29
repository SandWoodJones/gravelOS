{ lib, osConfig, pkgs, ... }: {
  config = lib.mkIf osConfig.gravelOS.desktop.enable {
    home.packages = with pkgs; [
      stremio
      # gravelOS.stremio-black-icon
      spotify
      telegram-desktop
      vesktop
      obsidian
    ];
  };
}

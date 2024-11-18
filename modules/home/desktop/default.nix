{ lib, osConfig, pkgs, ... }: {
  config = lib.mkIf osConfig.gravelOS.desktop.enable {
    home.packages = with pkgs; [
      stremio
      # gravelOS.stremio-black-icon
      spotify
      telegram-desktop
      vesktop
      obsidian
      libreoffice-qt6-fresh hunspell hunspellDicts.pt_BR hunspellDicts.en_US
      krita
      gimp
      gravelOS.UnsupOpen
    ];
  };
}

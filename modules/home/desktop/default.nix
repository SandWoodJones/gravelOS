{ lib, config, pkgs, ... }: {
  config = lib.mkIf config.gravelOS.desktop.enable {
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
      qbittorrent-enhanced
    ];
  };
}

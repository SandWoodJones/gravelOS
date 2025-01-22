{ pkgs, ... }: {
  gravelOS = {
    networking.bluetooth.mediaControls = true;
    desktop = {
      blender.enable = true;
      gaming.openMW.enable = true;
    };
  };

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
      gravelOS.pico8
    ];
 
  home.stateVersion = "24.05";
}

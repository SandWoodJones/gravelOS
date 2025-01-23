{ pkgs, ... }: {
  gravelOS = {
    firefox = {
      enable = true;
      enableConfig = true;
    };
  
    networking.bluetooth.mediaControls = true;
  };
  
  home.packages = with pkgs; [
    stremio
    spotify
    telegram-desktop
    vesktop
    obsidian
    libreoffice-qt6-fresh hunspell hunspellDicts.pt_BR hunspellDicts.en_US
    gravelOS.pico8
  ];

  home.stateVersion = "24.11";
}

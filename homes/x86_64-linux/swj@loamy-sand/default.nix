{ pkgs, ... }: {
  gravelOS = {
    xdg = { enable = true; remakeDirs = true; };
    ssh.enable = true;

    bluetooth.mediaControls = true;

    git = { enable = true; enableConfig = true; };
    firefox = { enable = true; enableConfig = true; };
    helix = {
      enable = true;
      enableConfig = true;
      defaultEditor = true;
    };
    mpv = { enable = true; enableConfig = true; };
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

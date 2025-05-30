{ pkgs, ... }: {
  gravelOS = {
    cli = {
      rm.enable = false;
      zoxide.cdReplace = true;      
    };

    xdg = { enable = true; remakeDirs = true; };
    ssh.enable = true;

    zsh = { enable = true; enableConfig = true; };
    git = { enable = true; enableConfig = true; };

    wezterm = { enable = true; enableConfig = true; };
    helix = {
      enable = true;
      enableConfig = true;
      defaultEditor = true;
    };

    firefox = { enable = true; enableConfig = true; };
    mpv = { enable = true; enableConfig = true; };
  };

  home.packages = with pkgs; [
      stremio
      spotify
      telegram-desktop
      vesktop
      obsidian
      libreoffice-qt6-fresh hunspell hunspellDicts.pt_BR hunspellDicts.en_US
      krita
      gimp
      qbittorrent-enhanced
      gravelOS.pico8
      godot_4
      aseprite
      heroic
      bolt-launcher
      gravelOS.quadrilateralcowboy
      r2modman
    ];

  home.stateVersion = "24.05";
}

{ pkgs, ... }: {
  gravelOS = {
    cli = {
      rm.enable = false;
      zoxide.cdReplace = true;      
    };
  
    hyprland = {
      enable = true;
      theming.gaps.smart = true;
      services = {
        hyprpolkit.enable = true;
        nm-applet.enable = true;
        rofi.enable = true;

        hypridle = {
          enable = true;
          settings = {
            dimming.enable = true;
            locking = { enable = true; dimming.enable = true; };
            screenOff.enable = true;
            hibernation.enable = true;
          };
        };
      };      
    };
  
    xdg = { enable = true; remakeDirs = true; };
    ssh.enable = true;

    bluetooth.mediaControls = true;

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
    spotifywm
    telegram-desktop
    vesktop
    obsidian
    libreoffice-qt6-fresh hunspell hunspellDicts.pt_BR hunspellDicts.en_US
    gravelOS.pico8
    heroic
    bolt-launcher
    texstudio
  ];

  home.stateVersion = "24.11";
}

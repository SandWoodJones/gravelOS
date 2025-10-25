{
  pkgs,
  ...
}:
let
  idKey = /home/swj/.ssh/id_swj;
in
{
  gravelOS = {
    system = {
      networking = {
        bluetooth.mediaControls.enable = true;
        ssh = {
          identityPath = idKey;
          avahi.enable = true;
        };
      };
      xdg.defaultBaseDirs.enable = true;
      syncthing.enable = true;
    };

    cli = {
      rm.enable = false;
      git.signing.ssh = {
        enable = true;
        keyPath = idKey;
      };
      helix.enable = true;
    };

    desktop = {
      launcher.rofi.enable = true;
      wezterm.enable = true;
      mpv.enable = true;
      firefox = {
        enable = true;
        pdfDefault.enable = true;
      };
    };

    hyprland = {
      enable = true;
      settings.theming.smart.enable = true;
    };
  };

  home.packages = with pkgs; [
    stremio
    spotifywm
    telegram-desktop
    vesktop
    obsidian
    libreoffice-qt6-fresh
    hunspell
    hunspellDicts.pt_BR
    hunspellDicts.en_US
    gravelOS.pico8
    heroic
    bolt-launcher
    texstudio
    qbittorrent-enhanced
    bottles

    grim
    slurp
    kdePackages.dolphin
  ];

  home.stateVersion = "24.11";
}

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
      zoxide.cdReplace = true;
      git.signing.ssh = {
        enable = true;
        keyPath = idKey;
      };
      helix = {
        enable = true;
        default.enable = true;
      };
      eza.replace.enable = true;
    };

    desktop = {
      hyprland = {
        enable = true;
        theming.smart.enable = true;
        services.hypridle.enable = true;
      };
      launcher = {
        rofi = {
          enable = true;
          default.enable = true;
        };
      };
      wezterm = {
        enable = true;
        default.enable = true;
      };
      mpv = {
        enable = true;
        default.enable = true;
      };
      firefox = {
        enable = true;
        pdfDefault.enable = true;
      };
    };

    # hyprland = {
    #   enable = true;
    #   theming.gaps.smart = true;
    #   services = {
    #     hyprpolkit.enable = true;
    #     nm-applet.enable = true;
    #     rofi.enable = true;

    #     hypridle = {
    #       enable = true;
    #       settings = {
    #         dimming.enable = true;
    #         locking = {
    #           enable = true;
    #           dimming.enable = true;
    #         };
    #         screenOff.enable = true;
    #         hibernation.enable = true;
    #       };
    #     };
    #   };
    # };
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
  ];

  home.stateVersion = "24.11";
}

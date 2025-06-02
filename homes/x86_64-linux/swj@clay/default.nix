{
  pkgs,
  ...
}:
{
  gravelOS = {
    system = {
      networking.bluetooth.mediaControls.enable = true;
    };

    cli = {
      rm.enable = false;
      zoxide.cdReplace = true;
      git.signing.ssh = {
        enable = true;
        keyPath = /home/swj/.ssh/id_swj;
      };
      helix = {
        enable = true;
        default.enable = true;
      };
    };

    desktop = {
      mpv = {
        enable = true;
        default.enable = true;
      };
    };

    xdg = {
      enable = true;
      remakeDirs = true;
    };
    ssh.enable = true;

    wezterm = {
      enable = true;
      enableConfig = true;
    };

    firefox = {
      enable = true;
      enableConfig = true;
    };
  };

  home.packages = with pkgs; [
    stremio
    spotify
    telegram-desktop
    vesktop
    obsidian
    libreoffice-qt6-fresh
    hunspell
    hunspellDicts.pt_BR
    hunspellDicts.en_US
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
    (dbeaver-bin.override { override_xmx = "4096m"; })
    bottles
  ];

  home.stateVersion = "24.05";
}

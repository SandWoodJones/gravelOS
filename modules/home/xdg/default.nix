{ config, lib, ... }: {
  config = {
    xdg = {
      enable = true;
      userDirs = lib.mkIf config.gravelOS.xdg.lowercaseDirs {
        enable = true;
        createDirectories = true;
        desktop = "${config.home.homeDirectory}/desktop";
        documents = "${config.home.homeDirectory}/documents";
        download = "${config.home.homeDirectory}/downloads";
        music = null;
        pictures = "${config.home.homeDirectory}/media/pictures";
        publicShare = null;
        templates = null;
        videos = "${config.home.homeDirectory}/media/videos";
      };

      mimeApps = {
        enable = true;
        defaultApplications = {
          "image/png" = [ "org.kde.gwenview.desktop" ];
          "application/pdf" = [ "firefox.desktop" ];
          "application/x-bittorrent" = [ "org.qbittorrent.qBittorrent.desktop" ];
          "video/*" = [ "mpv.desktop" ];
        };
      };
    };
  };
}

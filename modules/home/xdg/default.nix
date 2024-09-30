{ config, lib, ... }: {
  config = lib.mkIf config.gravelOS.xdg.lowercaseDirs {
    xdg.userDirs = {
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
  };
}

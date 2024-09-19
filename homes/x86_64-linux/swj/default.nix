{ config, pkgs, ... }: {
  # home.homeDirectory = "/home/${config.home.username}";

  gravelOS = {
    bluetooth.mediaControls.enable = true;
    helix.enable = true;
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "${config.home.homeDirectory}/desktop";
    documents = "${config.home.homeDirectory}/documents";
    download = "${config.home.homeDirectory}/downloads";
    music = null;
    pictures = null;
    publicShare = null;
    templates = null;
    videos = null;
  };
 
  home.packages = with pkgs; [
    stremio
  ];


  home.stateVersion = "24.05";
}

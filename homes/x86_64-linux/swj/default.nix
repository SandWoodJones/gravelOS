{ config, osConfig, pkgs, ... }: {
  # home.homeDirectory = "/home/${config.home.username}";

  gravelOS = {
    bluetooth.mediaControls.enable = true;
  };

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

  programs.git = {
    enable = true;
    userEmail = "sandwoodjones@outlook.com";
    userName = "SandWood Jones";
  };
 
  home.packages = with pkgs; [
    stremio
    telegram-desktop
    vesktop
    spotify
  ];


  home.stateVersion = "24.05";
}

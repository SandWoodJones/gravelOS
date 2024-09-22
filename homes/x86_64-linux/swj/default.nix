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
    pictures = "${config.home.homeDirectory}/media/pictures";
    publicShare = null;
    templates = null;
    videos = "${config.home.homeDirectory}/media/videos";
  };

  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };
 
  home.packages = with pkgs; [
    stremio
    telegram-desktop
  ];


  home.stateVersion = "24.05";
}

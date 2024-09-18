{ config, lib, pkgs, ... }: {
  # home.homeDirectory = "/home/${config.home.username}";

  home.packages = with pkgs; [
    cowsay
  ];

  gravelOS.helix.enable = true;

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

  home.stateVersion = "24.05";
}

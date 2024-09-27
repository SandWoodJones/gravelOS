{ lib, config, pkgs, ... }: {
  nix = { inherit (lib.gravelOS.nix) settings; };

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
    extraConfig = {
      user.name = "SandWood Jones";
      user.email = "sandwoodjones@outlook.com";
      user.signingKey = "${config.home.homeDirectory}/.ssh/id_swj";
      gpg.format = "ssh";
      commit.gpgSign = true;
    };
  };
 
  home.packages = with pkgs; [
    stremio
    telegram-desktop
    vesktop
    spotify
  ];

  home.stateVersion = "24.05";
}

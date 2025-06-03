{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.system.xdg;
in
{
  options.gravelOS.system.xdg = {
    defaultBaseDirs.enable = lib.mkOption {
      default = false;
      example = true;
      description = "Whether to disable some XDG base home directories and rename the others as lowercase.";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.defaultBaseDirs.enable {
    xdg = {
      enable = true;
      userDirs = {
        enable = true;
        createDirectories = true;
        desktop = "${config.home.homeDirectory}/desktop";
        documents = "${config.home.homeDirectory}/documents";
        download = "${config.home.homeDirectory}/downloads";
        pictures = "${config.home.homeDirectory}/media/pictures";
        videos = "${config.home.homeDirectory}/media/videos";
        music = null;
        publicShare = null;
        templates = null;
      };
    };
  };
}

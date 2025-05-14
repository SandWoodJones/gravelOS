{ lib, config, ... }:
let
  cfg = config.gravelOS.xdg;

  hasPkg = pkgName: lib.gravelOS.hasElement lib.getName pkgName config.home.packages;
in {
  options.gravelOS.xdg = {
    enable = lib.mkOption {
      default = false;
      example = true;
      description = "Whether to enable gravelOS's management of home directories and mimeapps file.";
      type = lib.types.bool;
    };
    remakeDirs = lib.mkOption {
      default = false;
      example = true;
      description = "Whether to enable gravelOS's renamed and more concise home directories configuration.";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable {
    xdg = {
      enable = true;
      userDirs = lib.mkIf cfg.remakeDirs {
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

        defaultApplications = lib.mkMerge [
          (lib.mkIf (hasPkg "telegram-desktop") {
            "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
            "x-scheme-handler/tonsite" = [ "org.telegram.desktop.desktop" ];
            "x-scheme-handler/heroic" = [ "com.heroicgameslauncher.hgl.desktop" ];
          })

          (lib.mkIf (hasPkg "vesktop") {
            "x-scheme-handler/discord" = [ "vesktop.desktop" ];
          })
        ];

        associations.added = lib.mkMerge [
          (lib.mkIf (hasPkg "telegram-desktop") {
            "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
            "x-scheme-handler/tonsite" = [ "org.telegram.desktop.desktop" ];
          })
        ];
      };
    };
  };
}

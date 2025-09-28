{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.desktop.xdg;

  hasPkg = pkgName: lib.gravelOS.hasElement lib.getName pkgName config.home.packages;
in
{
  options.gravelOS.desktop.xdg = {
    defaultApplications.enable = lib.gravelOS.mkEnableDefault "handling default applications through the mimeapps.list file";
  };

  config = lib.mkIf cfg.defaultApplications.enable {
    xdg.mimeApps = {
      enable = true;

      defaultApplications = lib.mkMerge [
        (lib.mkIf (hasPkg "telegram-desktop") {
          "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
          "x-scheme-handler/tonsite" = [ "org.telegram.desktop.desktop" ];
        })

        (lib.mkIf (hasPkg "heroic") {
          "x-scheme-handler/heroic" = [ "com.heroicgameslauncher.hgl.desktop" ];
        })

        (lib.mkIf (hasPkg "vesktop") {
          "x-scheme-handler/discord" = [ "vesktop.desktop" ];
        })

        (lib.mkIf config.gravelOS.desktop.mpv.enable {
          "video/mp4" = [ "mpv.desktop" ];
          "video/x-matroska" = [ "mpv.desktop" ];
        })

        (lib.mkIf config.gravelOS.desktop.firefox.pdfDefault.enable {
          "application/pdf" = [ "firefox.desktop" ];
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
}

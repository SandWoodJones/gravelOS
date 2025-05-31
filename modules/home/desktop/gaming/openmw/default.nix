{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.desktop.gaming.openmw;
in
{
  options.gravelOS.desktop.gaming.openmw = {
    enable = lib.mkEnableOption "OpenMW";
    tools.enable = lib.mkEnableOption "OpenMW and Morrowind modding tools";
    thumbnailers.enable = lib.mkEnableOption "file manager thumbnailers for common OpenMW files";
  };

  config = {
    home.packages = builtins.concatLists [
      (lib.optional cfg.enable pkgs.openmw)
      (lib.optionals cfg.tools.enable (
        with pkgs;
        [
          nifskope
          openmw-validator
          delta-plugin
          ddsView
        ]
      ))
    ];

    xdg = {
      # https://nowcodingtime.blogspot.com/2013/09/thumbnail-dds-texture-files-in-ubuntu.html
      dataFile = lib.mkIf cfg.thumbnailers.enable {
        "thumbnailers/dds.thumbnailer".text = ''
          [Thumbnailer Entry]
          Exec=${pkgs.imagemagick}/bin/magick %i -thumbnail x%s png:%o
          MimeType=image/x-dds;
        '';

        "thumbnailers/tga.thumbnailer".text = ''
          [Thumbnailer Entry]
          Exec=${pkgs.imagemagick}/bin/magick %i -thumbnail x%s png:%o
          MimeType=image/x-tga;
        '';
      };
    };
  };
}

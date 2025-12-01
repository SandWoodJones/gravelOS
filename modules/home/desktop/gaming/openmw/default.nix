# TODO: make a module for modding openmw through nix

{
  pkgs,
  lib,
  config,
  inputs,
  system,
  ...
}:
let
  cfg = config.gravelOS.desktop.gaming.openmw;
in
{
  options.gravelOS.desktop.gaming.openmw = {
    enable = lib.mkEnableOption "OpenMW";
  };

  config = lib.mkIf cfg.enable {
    home.packages =
      with pkgs;
      [
        openmw
        nifskope
      ]
      ++ (with inputs.openmw-nix.packages.${system}; [
        openmw-validator
        delta-plugin
      ]);

    xdg = {
      # https://nowcodingtime.blogspot.com/2013/09/thumbnail-dds-texture-files-in-ubuntu.html
      dataFile = {
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

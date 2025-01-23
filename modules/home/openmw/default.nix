{ pkgs, lib, config, ... }:
let
  cfg = config.gravelOS.openmw;

  ddsView = pkgs.python3Packages.buildPythonApplication {
    pname = "UnsupOpen";
    version = "0.1.0";
    src = ./ddsView;

    nativeBuildInputs = [ pkgs.copyDesktopItems ];
    propagatedBuildInputs = with pkgs.python3Packages; [ click pillow pkgs.perl540Packages.FileMimeInfo ];

    desktopItems = [
      (pkgs.makeDesktopItem {
        name = "unsup-open";
        desktopName = "UnsupOpen";
        exec = "unsup-open %f";
        mimeTypes = ["image/x-dds"];
        startupNotify = false;
        noDisplay = true;
      })
    ];
  };
in {
  options.gravelOS.openmw = {
    enable = lib.mkOption {
      default = false;
      example = true;
      description = "Whether to enable OpenMW and modding tools.";
      type = lib.types.bool;
    };
    thumbnailers = lib.mkOption {
      default = false;
      example = true;
      description = "Whether to enable file manager thumbnailers for common openMW files.";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable {    
    home.packages = with pkgs; [
      openmw
      nifskope
      openmw-validator
      delta-plugin
      ddsView
    ];

    xdg = {
      # https://nowcodingtime.blogspot.com/2013/09/thumbnail-dds-texture-files-in-ubuntu.html
      dataFile = lib.mkIf cfg.thumbnailers {
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

      mimeApps = {
        defaultApplications."image/x-dds" = [ "unsup-open.desktop" ];
        associations.removed."image/x-dds" = [ "okularApplication_kimgio.desktop" ];
      };
    };
  };
}

{ osConfig, config, lib, pkgs, inputs, system, ... }: lib.mkIf (osConfig.gravelOS.desktop.gaming.enable && config.gravelOS.gaming.openMW.enable) {
  home.packages = with pkgs; [
    openmw
    #gravelOS.TES3Merge
    gravelOS.t3t
    nifskope
    openmw-validator
  ] ++ (with inputs.openmw-nix.packages.${system}; [
    delta-plugin
  ]);

  xdg = {
    # https://nowcodingtime.blogspot.com/2013/09/thumbnail-dds-texture-files-in-ubuntu.html
    dataFile."thumbnailers/dds.thumbnailer".text = ''
      [Thumbnailer Entry]
      Exec=${pkgs.imagemagick}/bin/magick %i -thumbnail x%s png:%o
      MimeType=image/x-dds;
    '';

    mimeApps = {
      defaultApplications."image/x-dds" = [ "t3t_ddsview.desktop" ];
      associations.removed."image/x-dds" = [ "okularApplication_kimgio.desktop" ];
    };
  };
}

# TODO: use stylix for font configuration

{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.desktop;
in
{
  options.gravelOS.desktop = {
    display.enable = lib.mkEnableOption "graphical display support";
  };

  config = lib.mkIf cfg.display.enable {
    services.xserver.enable = true;

    xdg.portal.xdgOpenUsePortal = true;

    fonts = {
      fontconfig.useEmbeddedBitmaps = true;
      enableDefaultPackages = true;
      packages = with pkgs; [
        font-awesome
        nerd-fonts.symbols-only
        nerd-fonts.noto
        noto-fonts-cjk-sans
      ];
    };

    environment.systemPackages = with pkgs; [
      xclip
      wl-clipboard

      posy-cursors
    ];
  };
}

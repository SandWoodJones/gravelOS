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
      enableDefaultPackages = true;
      packages = with pkgs; [
        font-awesome
        nerd-fonts.symbols-only
        nerd-fonts.noto
        noto-fonts-cjk-sans
        cm_unicode
      ];

      fontconfig = {
        useEmbeddedBitmaps = true;
        defaultFonts = {
          sansSerif = [
            "DejaVu Sans"
            "Noto Sans Nerd Font"
            "Noto Sans CJK"
            "Symbols Nerd Font"
            "FontAwesome"
          ];

          serif = [
            "DejaVu Serif"
            "CMU Serif"
            "Noto Serif Nerd Font"
            "Symbols Nerd Font"
            "FontAwesome"
          ];

          monospace = [
            "DejaVu Sans Mono"
            "Noto Sans Mono Nerd Font"
            "Symbols Nerd Font"
            "FontAwesome"
          ];

          emoji = [
            "Noto Color Emoji"
            "Symbols Nerd Font"
          ];
        };
      };
    };

    environment.systemPackages = with pkgs; [
      wl-clipboard-rs
      posy-cursors
    ];
  };
}

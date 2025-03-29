{ pkgs, lib, config, ... }:
let
  cfg = config.gravelOS.display;
in {
  options.gravelOS.display = {
    enable = lib.mkOption {
      default = false;
      example = true;
      description = "Whether to enable graphical display support";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable {
    services.xserver.enable = true;

    # TODO: move to stylix
    fonts = {
      fontconfig.useEmbeddedBitmaps = true;
      enableDefaultPackages = true;
      packages = with pkgs; [
        font-awesome nerd-fonts.symbols-only nerd-fonts.noto
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

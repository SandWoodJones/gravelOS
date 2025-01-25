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

    fonts.packages = with pkgs; [
      noto-fonts noto-fonts-cjk-sans noto-fonts-emoji
      liberation_ttf
    ];

    environment.systemPackages = with pkgs; [
      xclip
      wl-clipboard
      posy-cursors
    ];
  };
}


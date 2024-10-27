{ config, lib, pkgs, ... }:
let
  cfg = config.gravelOS.desktop;
in {
  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      services = {
        xserver.enable = true;
        displayManager.sddm.enable = true;
        desktopManager.plasma6.enable = true;       
      };

      programs.partition-manager.enable = true;

      fonts.packages = with pkgs; [
        noto-fonts noto-fonts-cjk-sans noto-fonts-emoji
        liberation_ttf
      ];

      environment.systemPackages = with pkgs; [
        wl-clipboard
        posy-cursors
      ];
    })
  
    (lib.mkIf (cfg.enable && cfg.audio.enable) {
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa = { enable = true; support32Bit = true; };
        pulse.enable = true;
      };
    })
  ];
}


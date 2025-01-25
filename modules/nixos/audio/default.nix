{ lib, config, ... }:
let
  cfg = config.gravelOS.audio;
in {
  options.gravelOS.audio = {
    enable = lib.mkEnableOption "audio support";
  };

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa = { enable = true; support32Bit = true; };
      pulse.enable = true;
    };
  };
}

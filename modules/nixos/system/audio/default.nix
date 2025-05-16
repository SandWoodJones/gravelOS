{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.system.audio;
in
{
  options.gravelOS.system.audio = {
    enable = lib.mkEnableOption "audio with Pipewire.";
  };

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
  };
}

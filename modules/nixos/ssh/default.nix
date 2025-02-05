# TODO: use secrets to have fixed ssh keys for hosts

{ lib, config, ... }:
let
  cfg = config.gravelOS.ssh;
in {
  options.gravelOS.ssh = {
    enable = lib.mkEnableOption "SSH";
    secure = lib.mkOption {
      default = false;
      example = true;
      description = "Whether to disable SSH login without private key";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings.PasswordAuthentication = cfg.secure;
      settings.KbdInteractiveAuthentication = cfg.secure;
    };
  };
}

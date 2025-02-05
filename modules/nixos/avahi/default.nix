{ lib, config, ... }:
let
  cfg = config.gravelOS.avahi;
in {
  options.gravelOS.avahi.enable = lib.mkOption {
    default = false;
    example = true;
    description = "Whether to enable Avahi services with publishing.";
    type = lib.types.bool;
  };

  config = lib.mkIf cfg.enable {
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        addresses = true;
      };
    };
  };
}

# TODO: remove strict_env when it becomes the default

{
  lib,
  config,
  ...
}:
{
  programs.direnv = {
    enable = true;
    silent = true;
    settings.global = {
      load_dotenv = true;
      strict_env = true;
    };
  };

  services.angrr = {
    enable = true;
    period = "10d";
  };

  systemd.services.angrr = lib.mkIf config.gravelOS.system.services.nh.clean.enable {
    wantedBy = [ "nh-clean.service" ];
    before = [ "nh-clean.service" ];
  };
}

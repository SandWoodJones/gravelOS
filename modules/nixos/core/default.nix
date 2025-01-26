{ lib, config, ... }: {
  options.gravelOS = with lib; {
    desktop = {
      gaming = {
        steam.enable = lib.mkEnableOption "steam";
        enable = lib.mkEnableOption "gaming support";
      };
    };
  };

  config = {
    documentation = {
      dev.enable = true;
      man.generateCaches = true;
    };

    time.timeZone = "America/Sao_Paulo";
  };
}

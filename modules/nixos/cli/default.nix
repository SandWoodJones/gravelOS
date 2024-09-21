{ lib, config, pkgs, ... }: {
  options.gravelOS.nh-clean.enable = lib.mkOption {
    description = "Whether to enable nh's periodic garbage collection";
    type = lib.types.bool;
    default = true;
  };

  config = {
    documentation = {
      dev.enable = true;
      man.generateCaches = true;
    };
  
    programs.nh = {
      enable = true;
      clean = {
        enable = config.gravelOS.nh-clean.enable;
        extraArgs = "--keep 10 --keep-since 10d";
      };
    };

    programs.direnv = { enable = true; silent = true; };
    
    environment.systemPackages = with pkgs; [
      git
      helix
      wl-clipboard
      file
      trashy
    ];
  };
}

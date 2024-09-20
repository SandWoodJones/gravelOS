{ config, pkgs, ... }: {
  config = {
    documentation = {
      dev.enable = true;
      man.generateCaches = true;
    };
  
    programs.nh = {
      enable = true;
      clean = {
        enable = true;
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

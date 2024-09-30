{ config, ... }: {
  config = {
    boot = {
      loader = {
        systemd-boot.enable = true; 
        efi.canTouchEfiVariables = true; 
      };

      plymouth = {
        enable = true;
        theme = "breeze";   
      };
    };
  };
}

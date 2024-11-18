{ ... }: {
  gravelOS = {
    networking.bluetooth.mediaControls = true;
    desktop = {
      blender.enable = true;
      gaming.openMW.enable = true;
    };
  };
 
  home.stateVersion = "24.05";
}

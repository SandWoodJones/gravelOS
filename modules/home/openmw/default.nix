{ osConfig, config, lib, pkgs, inputs, ... }: lib.mkIf (osConfig.gravelOS.desktop.gaming.enable && config.gravelOS.gaming.openMW.enable) {
  home.packages = with pkgs; [
    openmw #gravelOS.TES3Merge
  ] ++ [
    inputs.openmw-nix.packages.x86_64-linux.delta-plugin
  ];
}

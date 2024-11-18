{ config, lib, pkgs, ... }:
let
  cfgDsk = config.gravelOS.desktop;
in {
  imports = [ ./openmw.nix ];
  config = lib.mkIf (cfgDsk.enable && cfgDsk.blender.enable) {
    home.packages = [ pkgs.blender ];
  };
}

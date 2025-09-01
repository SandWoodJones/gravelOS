{
  pkgs,
  lib,
  ...
}:
{
  gravelOS.desktop.xdg.defaultApplications.enable = lib.mkDefault true;

  home.packages = with pkgs; [
    work-sans
    dm-sans
  ];
}

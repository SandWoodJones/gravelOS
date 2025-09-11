{
  pkgs,
  lib,
  config,
  ...
}:
{
  gravelOS.desktop.xdg.defaultApplications.enable = lib.mkDefault true;

  home = {
    file."${config.xdg.configHome}/pulse/client.conf".text = "cookie-file = ${config.xdg.configHome}/pulse/cookie";
    
    packages = with pkgs; [
      work-sans
      dm-sans
    ];
  };
}

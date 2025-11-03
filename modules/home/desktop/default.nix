{
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    work-sans
    dm-sans
  ];

  xdg.configFile."pulse/client.conf".text = "cookie-file = ${config.xdg.configHome}/pulse/cookie";
}

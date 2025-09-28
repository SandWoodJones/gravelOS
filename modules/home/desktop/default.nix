{
  pkgs,
  config,
  ...
}:
{
  home = {
    file."${config.xdg.configHome}/pulse/client.conf".text =
      "cookie-file = ${config.xdg.configHome}/pulse/cookie";

    packages = with pkgs; [
      work-sans
      dm-sans
    ];
  };
}

# TODO: configure regreet
# TODO: configure regreet's hyprland instance's animations

{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.desktop.login;

  bg = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/heads/master/wallpapers/NixOS-Gradient-grey.png";
    name = "regreet-background.png";
    hash = "sha256-Tf4Xruf608hpl7YwL4Mq9l9egBOCN+W4KFKnqrgosLE=";
  };

  hyprland = {
    pkg = config.programs.hyprland.package;
    conf = pkgs.writeText "regreet-hyprland.conf" ''
      misc {
        disable_hyprland_logo=true
        force_default_wallpaper=0
      }
      exec-once = ${lib.getExe pkgs.swaybg} -i ${bg}
      exec-once = ${lib.getExe config.programs.regreet.package}; ${lib.getExe' hyprland.pkg "hyprctl"} dispatch exit
    '';
  };
in
{
  options.gravelOS.desktop.login = {
    regreet.enable = lib.mkEnableOption "ReGreet";
  };

  config = lib.mkIf cfg.regreet.enable {
    programs.regreet.enable = true;
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${lib.getExe' hyprland.pkg "Hyprland"} --config ${hyprland.conf}";
          user = "greeter";
        };
      };
    };
  };
}

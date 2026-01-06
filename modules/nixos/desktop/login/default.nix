# TODO: configure regreet
# TODO: configure regreet's hyprland instance's animations
# TODO: switch to cage whenever https://github.com/cage-kiosk/cage/issues/138 gets resolved

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

  swayCfg =
    pkgs.writeText "greetd-sway-config"
      # sway
      ''
        xwayland disable
        default_border none
        default_floating_border none
        input type:touchpad {
          dwt enabled
          tap enabled
          natural_scroll enabled
        }

        output * bg ${bg} fill
        exec "${lib.getExe pkgs.regreet}"
      '';
in
{
  options.gravelOS.desktop.login = {
    regreet.enable = lib.mkEnableOption "ReGreet";
  };

  config = lib.mkIf cfg.regreet.enable {
    programs.regreet = {
      enable = true;
      settings.background = {
        path = bg;
        fit = "Cover";
      };
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${lib.getExe pkgs.sway} --config ${swayCfg}";
          user = "greeter";
        };
      };
    };
  };
}

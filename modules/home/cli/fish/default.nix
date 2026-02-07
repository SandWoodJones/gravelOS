# TODO: add plugins

{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.cli.fish;
in
{
  options.gravelOS.cli.fish = {
    plugins = {
      pisces.enable = lib.gravelOS.mkEnableDefault "autoclosing symbol pairs";
    };
  };

  config = {
    programs.fish = {
      enable = true;
      shellAbbrs = {
        sus = "systemctl --user";
        storegrep = "nix-store --query --requisites /run/current-system | rg";
      };
      shellAliases = {
        cd = "z";
        cdi = "zi";
      };

      interactiveShellInit = # fish
        ''
          set -g fish_greeting
          set -g fish_escape_delay_ms 200
          ${import ./colors.nix { inherit config; }}
        '';

      shellInitLast = lib.mkOverride 1500 # fish
        ''
          status is-interactive; and begin
            __fish_motd_oneshot
          end
        '';

      binds = {
        "\\e\\e" = {
          inherit (config.programs.pay-respects) enable;
          command = "f";
          repaint = true;
        };
      };

      plugins = with pkgs.fishPlugins; [
        (lib.mkIf cfg.plugins.pisces.enable {
          inherit (pisces) src;
          name = "pisces";
        })

        (lib.mkIf config.programs.zoxide.enable {
          name = "zoxide";
          src = pkgs.fetchFromGitHub {
            owner = "icezyclon";
            repo = "zoxide.fish";
            rev = "3.0";
            hash = "sha256-OjrX0d8VjDMxiI5JlJPyu/scTs/fS/f5ehVyhAA/KDM=";
          };
        })
      ];
    };
  };
}

# TODO: add plugins

{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.fish = {
    enable = true;
    functions = import ./functions.nix { inherit pkgs lib; };
    shellAbbrs = {
      sus = "systemctl --user";
      gs = "git status";
      storegrep = "nix-store --query --requisites /run/current-system | rg";
    };
    shellAliases = {
      cd = "z";
      cdi = "zi";
    };

    interactiveShellInit = # fish
      ''
        set -g fish_greeting
        ${import ./colors.nix { inherit config; }}
      '';

    shellInitLast = # fish
      ''
        status is-interactive; and begin
          motd_oneshot
        end
      '';
  };
}

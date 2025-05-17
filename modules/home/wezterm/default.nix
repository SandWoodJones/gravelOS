{ pkgs, lib, config, ... }:
let
  cfg = config.gravelOS.wezterm;
in {
  options.gravelOS.wezterm = {
    enable = lib.mkEnableOption "WezTerm";
    enableConfig = lib.mkOption {
      default = false;
      example = true;
      description = "Whether to enable gravelOS's WezTerm configuration.";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      extraConfig = builtins.readFile ./wezterm.lua;
    };

    home.packages = [ pkgs.maple-mono.Normal-Variable ];

    wayland.windowManager.hyprland.settings."$terminal" = lib.mkIf config.gravelOS.hyprland.enable "wezterm";
  };
}

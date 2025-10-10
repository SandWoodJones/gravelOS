{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.desktop.wezterm;
in
{
  options.gravelOS.desktop.wezterm = {
    enable = lib.mkEnableOption "WezTerm and set it as the default terminal emulator";
  };

  config = lib.mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      extraConfig = builtins.readFile (
        pkgs.replaceVars ./wezterm.lua { color_scheme_slug = config.scheme.slug; }
      );

      colorSchemes.${config.scheme.slug} = with config.scheme.withHashtag; {
        foreground = base05;
        background = base00;
        cursor_bg = base06;
        cursor_fg = base10;
        cursor_border = base04;
        selection_bg = base02;
        scrollbar_thumb = base01;
        split = base03;
        ansi = [
          base00 # black
          base08 # red
          base0B # green
          base0A # yellow
          base0D # blue
          base0E # magenta
          base0C # cyan
          base06 # white
        ];
        brights = [
          base03 # bright black
          base12 # bright red
          base14 # bright green
          base13 # bright yellow
          base16 # bright blue
          base17 # bright magenta
          base15 # bright cyan
          base07 # bright white
        ];
      };
    };

    home.packages = [ pkgs.maple-mono.variable ];
  };
}

# TODO: further configure `mpv`

{ pkgs, lib, config, ... }:
let
  cfg = config.gravelOS.mpv;

  crossPlatformCopy = pkgs.writeShellScript "crossPlatformCopy" ''
    case "$1" in
      -c)
        shift
        if [[ -n "$WAYLAND_DISPLAY" ]]; then
          ${pkgs.wl-clipboard}/bin/wl-copy "$@"
        else
          echo -n "$@" | ${pkgs.xclip}/bin/xclip -silent -selection clipboard -in
        fi
      ;;

      -p)
        if [[ -n "$WAYLAND_DISPLAY" ]]; then
          ${pkgs.wl-clipboard}/bin/wl-paste
        else
          ${pkgs.xclip}/bin/xclip -selection clipboard -o
        fi
      ;;
    esac
  '';
in {
  options.gravelOS.mpv = {
    enable = lib.mkEnableOption "mpv";
    enableConfig = lib.mkOption {
      default = false;
      example = true;
      description = "Whether to enable gravelOS's mpv configuration.";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable {
    xdg.mimeApps.defaultApplications = lib.mkIf config.gravelOS.xdg.enable { "video/mp4" = [ "mpv.desktop" ]; };
  
    programs.mpv = lib.mkMerge [
      { enable = true; }

      (lib.mkIf cfg.enableConfig {
        config = {
          osd-bar = false;
          border = false;
          save-position-on-quit = true;
          video-sync = "display-resample";
          keep-open = true;
          autofit = "70%x60%";
        };

        scripts = with pkgs.mpvScripts; [
          uosc
          thumbfast
          smart-copy-paste-2
          evafast
        ];

        bindings = {
          "right"       = "seek   5; script-binding uosc/flash-progress";
          "left"        = "seek  -5; script-binding uosc/flash-progress";
          "shift+right" = "seek  30; script-binding uosc/flash-timeline";
          "shift+left"  = "seek -30; script-binding uosc/flash-timeline";
          "ctrl+right"  = "script-binding evafast/evafast";
          "m"           = "no-osd cycle mute; script-binding uosc/flash-volume";
          "up"          = "no-osd add volume  10; script-binding uosc/flash-volume";
          "down"        = "no-osd add volume -10; script-binding uosc/flash-volume";
          "WHEEL_UP"    = "no-osd add volume   2; script-binding uosc/flash-volume";
          "WHEEL_DOWN"  = "no-osd add volume  -2; script-binding uosc/flash-volume";

          "0" = "seek  0 absolute-percent; script-binding uosc/flash-timeline";
          "1" = "seek 10 absolute-percent; script-binding uosc/flash-timeline";
          "2" = "seek 20 absolute-percent; script-binding uosc/flash-timeline";
          "3" = "seek 30 absolute-percent; script-binding uosc/flash-timeline";
          "4" = "seek 40 absolute-percent; script-binding uosc/flash-timeline";
          "5" = "seek 50 absolute-percent; script-binding uosc/flash-timeline";
          "6" = "seek 60 absolute-percent; script-binding uosc/flash-timeline";
          "7" = "seek 70 absolute-percent; script-binding uosc/flash-timeline";
          "8" = "seek 80 absolute-percent; script-binding uosc/flash-timeline";
          "9" = "seek 90 absolute-percent; script-binding uosc/flash-timeline";
        };
      
        scriptOpts = {
          uosc = {
            timeline_style = "bar";
            timeline_size = 30;
            autohide = true;
          };

          SmartCopyPaste_II = {
            linux_copy = "${crossPlatformCopy} -c";
            linux_paste = "${crossPlatformCopy} -p";
          };
        };
      })
    ];
  };
}

# TODO: configure mpv

{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.desktop.mpv;
in
{
  options.gravelOS.desktop.mpv = {
    enable = lib.mkEnableOption "mpv and set it as the default video player";
  };

  config = lib.mkIf cfg.enable {
    programs.mpv = {
      enable = true;

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
      scriptOpts = {
        uosc = {
          timeline_style = "bar";
          timeline_size = 30;
          autohide = true;
        };

        SmartCopyPaste_II = {
          linux_copy = # sh
            ''${lib.getExe pkgs.wl-clipboard-rs} -i -se "clipboard" -rmlastnl'';
          linux_paste = # sh
            ''${lib.getExe pkgs.wl-clipboard-rs} -o -se "clipboard"'';

          copy_specific_keybind = ''["ctrl+c", "ctrl+C", "meta+c", "meta+C"]'';
          copy_keybind = ''["ctrl+alt+c", "ctrl+alt+C", "meta+alt+c", "meta+alt+C"]'';
          paste_specific_keybind = ''["ctrl+v", "ctrl+V", "meta+v", "meta+V"]'';
          paste_keybind = ''["ctrl+alt+v", "ctrl+alt+V", "meta+alt+v", "meta+alt+V"]'';
        };
      };

      bindings = {
        "right" = "seek   5; script-binding uosc/flash-progress";
        "left" = "seek  -5; script-binding uosc/flash-progress";
        "shift+right" = "seek  30; script-binding uosc/flash-timeline";
        "shift+left" = "seek -30; script-binding uosc/flash-timeline";
        "ctrl+right" = "script-binding evafast/evafast";
        "m" = "no-osd cycle mute; script-binding uosc/flash-volume";
        "up" = "no-osd add volume  10; script-binding uosc/flash-volume";
        "down" = "no-osd add volume -10; script-binding uosc/flash-volume";
        "WHEEL_UP" = "no-osd add volume   2; script-binding uosc/flash-volume";
        "WHEEL_DOWN" = "no-osd add volume  -2; script-binding uosc/flash-volume";

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
    };
  };
}

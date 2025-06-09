{ pkgs }:
pkgs.writeShellScript "crossPlatformCopy" ''
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
''

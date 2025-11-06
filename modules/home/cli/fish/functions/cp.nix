{
  pkgs,
  lib,
  ...
}:
{
  programs.fish.functions.cp = # fish
    ''
      if test (count $argv) -ne 1; or string match -q "\-*" "$argv[1]"
        command "${lib.getExe pkgs.xcp}" $argv
        return 0
      end

      if not test -e "$argv[1]"
        set_color red
        echo "$argv[1] does not exist" >&2
        set_color normal
        return 1
      end

      if not test -f "$argv[1]"
        set_color red
        echo "$argv[1] is not a regular file" >&2
        set_color normal
        return 1
      end

      if not test -r "$argv[1]"
        set_color red
        echo "$argv[1] is not readable" >&2
        set_color normal
        return 1
      end

      command "${lib.getExe pkgs.wl-clipboard-rs}" -i -se "clipboard" < "$argv[1]"
    '';
}

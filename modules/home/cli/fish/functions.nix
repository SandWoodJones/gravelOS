{
  pkgs,
  lib,
}:
{
  tp = # fish
    ''
      set -l cmd "${lib.getExe pkgs.trashy}"

      if test (count $argv) -eq 1 -a "$argv[1]" = ".trashyignore"
        command "$cmd" $argv
        return 0
      end

      if not test -e ".trashyignore"
        command "$cmd" $argv
        return 0
      end

      set -l ignore_patterns ".trashyignore"
      for line in (cat ".trashyignore")
        if test -n "$line"; and not string match -q "#*" -- "$line"
          set -a ignore_patterns "$line"
        end
      end

      set -l args
      for arg in $argv
        set -l exclude false

        for pattern in $ignore_patterns
          if string match -q -- "*/" "$pattern"
            if test -d "$arg" -a "$arg/" = "$pattern"
              set exclude true
              break
            end
          else
            if test "$arg" = "$pattern"
              set exclude true
              break
            end
          end
        end

        if not "$exclude"
          set -a args "$arg"
        end
      end

      command "$cmd" $args
    '';

  cp = # fish
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

  motd_oneshot =
    with pkgs; # fish
    ''
      set -l flag_file "/tmp/gravelOS_motd_flag"
      if test -e "$flag_file"
        return 0
      end

      touch "$flag_file"

      "${lib.getExe fortune}" -a | "${lib.getExe neo-cowsay}" -n --random | "${lib.getExe' nms "nms"}" -a | "${lib.getExe lolcat}" -F 0.01
      set -l ps $pipestatus

      if test $ps[1] -eq 0; and test $ps[2] -eq 0; and test $ps[3] -eq 0; and test $ps[4] -eq 0
        read --silent --prompt-str ""
        clear
      end
    '';
}

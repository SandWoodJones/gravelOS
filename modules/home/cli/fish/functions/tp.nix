{
  pkgs,
  lib,
  ...
}:
{
  programs.fish.functions.tp = # fish
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
}

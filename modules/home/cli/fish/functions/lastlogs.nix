_: {
  programs.fish = {
    functions = {
      "lastlogs" =
        #fish
        ''
          argparse 'f/follow' -- $argv
          or return 1

          set -l unit $argv[1]
          if test -z "$unit"
            set_color red
            echo "missing unit name"
            set_color normal
            return 1
          end

          set -l id (systemctl show -p InvocationID --value $unit)
          if test -n "$id"
            set -l cmd journalctl _SYSTEMD_INVOCATION_ID=$id -u $unit
            if set -q _flag_follow
              set -a cmd -f
            end

            $cmd
          else
            set_color red
            echo "could not find InvocationID for unit '$unit'"
            set_color normal
            return 1
          end
        '';
      "ulastlogs" =
        #fish
        ''
          argparse 'f/follow' -- $argv
          or return 1

          set -l unit $argv[1]
          if test -z "$unit"
            set_color red
            echo "missing unit name"
            set_color normal
            return 1
          end

          set -l id (systemctl --user show -p InvocationID --value $unit)
          if test -n "$id"
            set -l cmd journalctl --user _SYSTEMD_INVOCATION_ID=$id -u $unit
            if set -q _flag_follow
              set -a cmd -f
            end

            $cmd
          else
            set_color red
            echo "could not find InvocationID for user unit '$unit'"
            set_color normal
            return 1
          end
        '';
    };

    completions = {
      lastlogs =
        #fish
        ''
          complete -c lastlogs -x -a \
            '(systemctl list-units --type=service --all --no-legend --plain | string replace -r "\s+.*" "")'
          complete -c lastlogs -s f -l follow -d 'Follow the journal'
          
          complete -c ulastlogs -x -a \
            '(systemctl --user list-units --type=service --all --no-legend --plain | string replace -r "\s+.*" "")'
          complete -c ulastlogs -s f -l follow -d 'Follow the journal'
        '';
    };
  };
}

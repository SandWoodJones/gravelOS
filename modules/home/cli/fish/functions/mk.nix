{
  pkgs,
  lib,
  ...
}:
{
  programs.fish = {
    functions = {
      mk =
        # fish
        ''
          if test (count $argv) -ne 1
            echo "Usage: mk <template_basename>"
            return 1
          end

          set -l template $argv[1]

          if not set -q XDG_TEMPLATES_DIR
            set_color red
            echo "Error: \$XDG_TEMPLATES_DIR is not set" >&2
            set_color normal
            return 1
          end

          if not test -d "$XDG_TEMPLATES_DIR"
            set_color red
            echo "Error: \$XDG_TEMPLATES_DIR is not a directory" >&2
            set_color normal
            return 1
          end

          set -l sources $XDG_TEMPLATES_DIR/$template*
          if test (count $sources) -eq 0
            set_color yellow
            echo "Error: no template found in '$XDG_TEMPLATES_DIR' matching '$template'" >&2
            set_color normal
            return 1
          end

          set -l source_file $sources[1]
          if test (count $sources) -gt 1
            set_color yellow
            echo "Warning: multiple matches found, using the first one" >&2
            set_color normal
          end

          set -l first_line (head -n 1 "$source_file" 2>/dev/null)
          set -l name (string replace -r '^.*!\{([^}]+)\}.*$' '$1' -- "$first_line")
          set -l name_found false
          set -l destination (basename "$source_file")

          if test "$name" != "$first_line" -a -n "$name"
            set destination $name
            set name_found true
          end

          if test -e "$destination"
            set_color red
            echo "Error: '$destination' already exists" >&2
            set_color normal
            return 1
          end

          if $name_found
            tail -n +2 "$source_file" > "$destination"
            if test $status -ne 0
              set_color red
              echo "Error: failed to create '$destination'" >&2
              set_color normal
              return 1
            end
          else
            if not "${lib.getExe pkgs.xcp}" --no-progress --no-perms -L "$source_file" "$destination"
              set_color red
              echo "Error: failed to copy template" >&2
              set_color normal
              return 1
            end
          end

          echo "'$destination' created"
        '';

      "__fish_mk_get_templates" =
        # fish
        ''
          if not set -q XDG_TEMPLATES_DIR; or not test -d "$XDG_TEMPLATES_DIR"
            return 0
          end

          set -l files $XDG_TEMPLATES_DIR/*

          for f in $files
            if test -f "$f"
              set -l basename (basename "$f")
              set -l parts (string split -r -m1 . $basename)
              echo $parts[1]
            end
          end
        '';
    };

    completions.mk = # fish
      ''complete -c mk -n 'not __fish_seen_subcommand_from (commandline -opc)' -a '(__fish_mk_get_templates)' -f'';
  };
}

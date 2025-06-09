{
  pkgs,
  lib,
}:
''
  #!/usr/bin/env zsh
  tp() {
    local cmd="${lib.getExe pkgs.trashy}"

  	if [[ ! -f ".trashyignore" ]]; then
  		$cmd "$@"
  		return 0
  	fi

  	local ignore_patterns=()
  	while IFS= read -r line; do
  		if [[ -n "$line" && "$line" != \#* ]]; then
        ignore_patterns+=("$line")
      fi
  	done < ".trashyignore"
  	ignore_patterns+=(".trashyignore")

  	local args=()
  	for arg in "$@"; do
  		local exclude=false

  		for pattern in "''${ignore_patterns[@]}"; do
  			if [[ "$pattern" == */ ]]; then
  			  if [[ -d "$arg" && "$arg"/ == "$pattern" ]]; then
            exclude=true
            break
          fi
  			else
  				if [[ "$arg" == "$pattern" ]]; then
            exclude=true
            break
          fi
  			fi
  		done

      if [[ "$exclude" == false ]]; then
        args+=("$arg")
      fi
  	done

  	$cmd "''${args[@]}"
  }
''

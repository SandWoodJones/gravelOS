{
  pkgs,
  lib,
}:
''
  #!/usr/bin/env zsh
  cp() {
  	if [[ "$1" == -* ]] || (( $# != 1 )); then
  		command ${lib.getExe pkgs.xcp} "$@"
      return 0
    fi
    
  	if [[ ! -e "$1" ]]; then
  		print -u2 -- "\e[31m$1 does not exist \e[0m" 
  		return 1
  	elif [[ ! -f "$1" ]]; then
  		print -u2 -- "\e[31m$1 is not a regular file \e[0m" 
  		return 1
  	elif [[ ! -r "$1" ]]; then
  		print -u2 -- "\e[31m$1 is not readable \e[0m" 
  		return 1
  	fi

  	wl-copy < "$1"
  }
''

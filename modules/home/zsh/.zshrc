bindkey "''${key[Up]}" up-line-or-search # https://wiki.nixos.org/wiki/Zsh#Zsh-autocomplete_not_working

shell() {
	if [ -z "$1" ]; then
		printf "\\e[31mNo devshell specified\\e[0m\\nRun with -r to delete direnv files from current directory\nRun with -u to manually reload the nix shell environment\n"
		return 1
	fi

	case "$1" in
		"-r")
			if [[ -f ".envrc" ]]; then command rm .envrc; fi
			if [[ -d ".direnv" ]]; then command rm -r .direnv; fi
		;;

		"-u")
			if [[ ! -f ".envrc" ]]; then
				printf "\\e[31mNot in a direnv directory\n"
				return 1
			fi

			if ! head -n 1 ".envrc" | grep -xq "nix_direnv_manual_reload"; then sed -i "1inix_direnv_manual_reload" ".envrc"; fi
			command rm -r .direnv/flake-*
			nix-direnv-reload
		;;

		*)
			echo "use flake $GRAVELOS_PATH#$1" > .envrc
			direnv allow
	esac

	return 0		
}

cp() {
	if [[ $# -eq 1 ]]; then
		if [[ ! -f "$1" ]]; then
			printf "\\e[31m%s is not a file\n" $1
			return 1
		fi

		case "$XDG_SESSION_TYPE" in
			x11)
				type=$(file --mime-type -b "$1")

				if [[ "$type" == image/* ]]; then
					xclip -sel clip -t "$type" "$1"
				else
					xclip -sel clip "$1"
				fi
			;;

			wayland) wl-copy < $1 ;;

			*)
				printf "\\e[31munknown session type %s\n" "$XDG_SESSION_TYPE"
				return 1
			;;
		esac
	else
		command cp $@
	fi

	return 0
}

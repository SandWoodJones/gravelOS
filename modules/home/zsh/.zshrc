bindkey "''${key[Up]}" up-line-or-search # https://wiki.nixos.org/wiki/Zsh#Zsh-autocomplete_not_working

# TODO: edit function to use xcp
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

tp() {
	if [[ ! -f ".trashyignore" ]]; then
		command trash put $@
		return 0
	fi

	local ignore_patterns=()
	while IFS= read -r line; do
		[[ -n $line && $line != \#* ]] && ignore_patterns+=("$line")
	done < ".trashyignore"
	ignore_patterns+=(".trashyignore")

	local args=()
	for arg in "$@"; do
		local exclude=false
		for pattern in "${ignore_patterns[@]}"; do
			if [[ $pattern == */ ]]; then
				[[ -d $arg && $arg/ == $pattern ]] && exclude=true && break
			else
				[[ $arg == $pattern ]] && exclude=true && break
			fi
		done
		$exclude || args+=("$arg")
	done

	command trash put "${args[@]}"
}

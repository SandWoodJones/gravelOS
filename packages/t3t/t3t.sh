#!/usr/bin/env bash
DIRDIFF_DESC="Runs tes3cmd diff against every .esp file pair from the given directories"
DDSVIEW_DESC="Opens a .dds file as a .png with your default image viewer"

extract_final_path() {
  local filename=$(basename "$1")
  local parent_dir=$(basename "$(dirname "$1")")
  echo "$parent_dir/$filename"
}

help() {
  case $1 in
    "dirdiff")
      printf "$DIRDIFF_DESC\n\n"
      printf "Usage: t3t dirdiff [OPTIONS] <DIR1> <DIR2>\n\n"
      printf "Options:\n"
      printf "  %-15s%s\n" "-h, --help" "Print this help\n"
      printf "  %-15s%s\n" "-k, --keep" "Don't delete generated diff.txt files after usage"
    ;;

    "ddsview")
      printf "$DDSVIEW_DESC\n"
    ;;

    *)
      printf "Usage: t3t <COMMAND>\n"
      printf "To get more help for individual commands:\n"
      printf "  t3t <command> -h\n\n"
      printf "Commands:\n\n"
      printf "  %-15s%s\n" "ddsview" "$DDSVIEW_DESC"
      printf "\nThese commands should be run from within the Morrowind game directory structure:\n\n"
      printf "  %-15s%s\n" "dirdiff" "$DIRDIFF_DESC"
  esac
}

dirdiff() {
  local keep_diffs=false

  while [[ "$1" == -* ]]; do
    case "$1" in
      -h|--help)
        help "dirdiff"
        return 0;;
      -k|--keep)
        keep_diffs=true
        shift;;
      *)
        printf "\\e[31mUnknown option: $1\n"
        return 1;;
    esac
  done

  if [[ $# -lt 2 ]]; then
    printf "\\e[31mOne or more input directories missing\n"
    return 1
  fi

  if [[ "$1" == "$2" ]] then
    printf "\\e[31mInput directories cannot be the same\n"
    return 1
  fi

  # remove trailing slashes
  dir1="${1%/}"
  dir2="${2%/}"

  if [ ! -d "$dir1" ]; then 
    printf "\\e[31m'$dir1' is not a directory\n"
    return 1
  fi

  if [ ! -d "$dir2" ]; then 
    printf "\\e[31m'$dir2' is not a directory\n"
    return 1
  fi

  for plugin1 in "$dir1"/*.esp; do
    if [ ! -f "$plugin1" ]; then continue; fi

    for plugin2 in "$dir2"/*.esp; do
      if [ ! -f "$plugin2" ]; then continue; fi

      output=$(tes3cmd diff --ne --sortsubrecs --ignore-type TES3 "$plugin1" "$plugin2")
      if [[ -n "$output" ]]; then
        printf "$(extract_final_path "$plugin1") \e[38;5;214m!=\e[0m $(extract_final_path "$plugin2")\n";
        if ! $keep_diffs; then
          rm "$plugin1"-diff.txt
          rm "$plugin2"-diff.txt
        fi
      fi
    done
  done

  return 0
}

ddsview() {
  if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    help "ddsview"
    return 0
  fi

  local temp_png="/tmp/$(basename "$1" .dds).png"
  magick "$1" "$temp_png"
  xdg-open "$temp_png"
}

case $1 in
  "dirdiff") dirdiff $2 $3 $4;;
  "ddsview") ddsview $2;;
  *) help ;;
esac

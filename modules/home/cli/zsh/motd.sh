#!/usr/bin/env zsh

# TODO: rewrite nms in rust

show_motd() {
  local fortune="@fortune@"
  local cowsay="@cowsay@"
  local nms="@nms@"
  local lolcat="@lolcat@"

  ("$fortune" -a | "$cowsay" -n --random | "$nms" -a | "$lolcat" -F 0.01)
}

MARKER="/tmp/gravelOS_motd_marker"
if [ ! -f "$MARKER" ]; then
  interrupted=0
  trap 'interrupted=1' INT

  show_motd

  trap - INT
  touch "$MARKER"

  if [ $interrupted -eq 0 ] && [ $? -eq 0 ]; then
    echo
    read -sk1 _
    clear
  fi
fi

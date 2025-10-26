{
  pkgs,
  lib,
  ...
}:
{
  programs.fish.enable = true;

  # https://wiki.nixos.org/wiki/Fish#Setting_fish_as_default_shell
  programs.bash.interactiveShellInit = ''
    if [[ $(${lib.getExe' pkgs.procps "ps"} --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
    then
      shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
      exec ${lib.getExe pkgs.fish} $LOGIN_OPTION
    fi
  '';
}

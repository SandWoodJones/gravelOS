{
  pkgs,
  lib,
  inputs,
  system,
  ...
}:
let
  els = lib.getExe inputs.even-less-secrets.packages.${system}.default;
in
{
  programs.fish.functions.motd_oneshot =
    with pkgs; # fish
    ''
      set -l flag_file "/tmp/gravelOS_motd_flag"
      if test -e "$flag_file"
        return 0
      end

      touch "$flag_file"

      "${lib.getExe fortune}" -a | "${lib.getExe neo-cowsay}" -n --random | "${els}" -a | "${lib.getExe lolcat}" -F 0.01
      set -l ps $pipestatus

      if test $ps[1] -eq 0; and test $ps[2] -eq 0; and test $ps[3] -eq 0; and test $ps[4] -eq 0
        read --silent --prompt-str ""
        clear
      end
    '';
}

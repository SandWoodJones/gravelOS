{ pkgs, writeScriptBin, symlinkJoin, ... }:
let
  name = "t3t";
  t3t-buildInputs = with pkgs; [
    tes3cmd
  ];
  script = (writeScriptBin name (builtins.readFile ./t3t.sh)).overrideAttrs(old: {
    buildCommand = "${old.buildCommand}\npatchShebangs $out";
  });
in symlinkJoin {
  inherit name;
  paths = [ script ] ++ t3t-buildInputs;
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = "wrapProgram $out/bin/${name} --prefix PATH : $out/bin";
}

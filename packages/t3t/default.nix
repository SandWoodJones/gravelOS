{
  pkgs,
  writeScriptBin,
  symlinkJoin,
  makeDesktopItem,
  lib,
  ...
}: let
  name = "t3t";
  t3t-buildInputs = with pkgs; [
    tes3cmd
    imagemagick
  ];

  script = (writeScriptBin name (builtins.readFile ./t3t.sh)).overrideAttrs (old: {
    buildCommand = "${old.buildCommand}\npatchShebangs $out";
  });

  desktop = makeDesktopItem {
    name = "t3t_ddsview";
    desktopName = "T3T DDSView";
    exec = "${script}/bin/t3t ddsview %f";
    mimeTypes = ["image/x-dds"];
    startupNotify = false;
    noDisplay = true;
  };
in
  symlinkJoin {
    inherit name;
    paths = [script desktop] ++ t3t-buildInputs;
    buildInputs = [pkgs.makeWrapper];
    postBuild = "wrapProgram $out/bin/${name} --prefix PATH : $out/bin";

    meta = {
      description = "A set of tools for help modding The Elder Scrolls III: Morrowind";
      platforms = lib.platforms.all;
    };
  }

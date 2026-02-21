# TODO: submit the .qmlls.ini tweak to home manager

{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.desktop.quickshell;

  mkConfig =
    name: src:
    let
      importPaths = lib.concatStringsSep ":" (
        map (p: "${p}/lib/qt-6/qml") (
          with pkgs;
          [
            qt6.qtdeclarative
            qt6.qtwayland
            libglvnd
            quickshell
          ]
        )
      );
    in
    pkgs.runCommandLocal "quickshell-config-${name}" { } ''
      mkdir -p $out
      cp -r ${src}/* $out/
      printf "[General]\nno-cmake-calls=true\nbuildDir=%s\nimportPaths=%s:${importPaths}" \
        "$out" "$out" > "$out/.qmlls.ini"
    '';
in
{
  options.gravelOS.desktop.quickshell = {
    enable = lib.mkEnableOption "Quickshell";
  };

  config = lib.mkIf cfg.enable {
    programs.quickshell = {
      enable = true;
      configs.default = mkConfig "default" ./default;
      activeConfig = "default";
    };

    home.packages =
      let
        qtEnv = with pkgs.qt6; env "qt-custom-${qtbase.version}" [ qtdeclarative ];
      in
      [
        qtEnv
        pkgs.libglvnd
      ];
  };
}

{ runCommand, makeBinaryWrapper, buildEnv, steam, ... }:
let
  wrapper = runCommand "steam-silent-wrapper" { nativeBuildInputs = [ makeBinaryWrapper ]; }
    ''
      mkdir -p $out/bin $out/share/applications

      makeWrapper ${steam}/bin/steam $out/bin/steam --add-flags "-silent"

      substitute ${steam}/share/applications/steam.desktop $out/share/applications/steam.desktop \
        --replace-fail "Exec=steam" "Exec=${steam}/bin/steam"
    '';
in buildEnv {
  inherit (steam) name meta passthru;
  paths = [ wrapper steam ];
  ignoreCollisions = true;
}

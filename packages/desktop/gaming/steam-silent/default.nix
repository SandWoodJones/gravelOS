{
  runCommand,
  makeWrapper,
  buildEnv,
  steam,
  ...
}:
let
  wrapper = runCommand "steam-silent-wrapper" { nativeBuildInputs = [ makeWrapper ]; } ''
    install -d $out/bin $out/share/applications

    makeWrapper ${steam}/bin/steam $out/bin/steam \
      --add-flags "-silent"

    substitute ${steam}/share/applications/steam.desktop $out/share/applications/steam.desktop \
      --replace "Exec=steam" "Exec=${steam}/bin/steam"
  '';
in

buildEnv {
  inherit (steam) name passthru;
  paths = [
    wrapper
    steam
  ];
  ignoreCollisions = true;

  meta = {
    inherit (steam.meta) mainProgram license;
    description = steam.meta.description + " (with silent startup)";
  };
}

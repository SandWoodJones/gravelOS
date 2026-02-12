# TODO: make this a home manager module for any xcursor package

{
  stdenvNoCC,
  fetchFromGitHub,
  hyprcursor,
  xcur2png,
}:

stdenvNoCC.mkDerivation rec {
  pname = "posy-hyprcursors";
  version = "1.6";

  src = fetchFromGitHub {
    owner = "simtrami";
    repo = "posy-improved-cursor-linux";
    tag = version;
    hash = "sha256-i0N/QB5uzqHapMCDl6h6PWPJ4GOAyB1ds9qlqmZacLY=";
  };

  nativeBuildInputs = [
    hyprcursor
    xcur2png
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/icons

    for theme in Posy_Cursor*; do
      hyprcursor-util --extract "$theme"

      NAME=$(sed -n 's/^Name=//p' "$theme/index.theme" | tr / _)
      COMMENT=$(sed -n 's/^Comment=//p' "$theme/index.theme")
      printf "name = %s\ndescription = %s\nversion = ${version}\ncursors_directory = hyprcursors\n" \
        "$NAME" "$COMMENT" > "extracted_$theme/manifest.hl"
      hyprcursor-util --create "extracted_$theme"
      mv theme_* "$out/share/icons/$theme"_Hyprcursor
    done

    runHook postInstall
  '';
}

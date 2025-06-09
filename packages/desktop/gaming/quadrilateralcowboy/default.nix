{
  lib,
  stdenv,
  requireFile,
  unzip,
  makeWrapper,
  autoPatchelfHook,
  imagemagick,
  makeDesktopItem,
  copyDesktopItems,
  SDL2,
  openal,
  libGL,
}:
stdenv.mkDerivation rec {
  pname = "quadrilateralcowboy";
  version = "1.0";

  src = requireFile {
    name = "quadrilateralcowboy-linux.zip";
    url = "https://blendogames.itch.io/quadrilateralcowboy";
    hash = "sha256-uQ6Y0BMO2kogFaPCHJ+ygY5lpYN+GGDTMZU+8cC0Fe4=";
  };

  nativeBuildInputs = [
    unzip
    makeWrapper
    autoPatchelfHook
    copyDesktopItems
    imagemagick
  ];

  buildInputs = [
    SDL2
    openal
    libGL
  ];

  desktopItems = [
    (makeDesktopItem {
      name = "quadrilateralcowboy";
      desktopName = "Quadrilateral Cowboy";
      exec = "quadrilateralcowboy";
      icon = "quadrilateralcowboy";
      categories = [ "Game" ];
    })
  ];

  installPhase = ''
    install -Dm755 qc.bin.x86_64 $out/libexec/qc.bin.x86_64
    install -Dm644 base/pak000.pk4 $out/libexec/base/pak000.pk4

    install -d "$out/share/icons/hicolor/128x128/apps"
    magick Icon.bmp "$out/share/icons/hicolor/128x128/apps/quadrilateralcowboy.png"

    runHook postInstall
  '';

  postFixup = ''
    makeWrapper $out/libexec/qc.bin.x86_64 $out/bin/quadrilateralcowboy \
      --set LD_LIBRARY_PATH "${lib.makeLibraryPath buildInputs}"
  '';

  meta = {
    description = "Single-player adventure in a cyberpunk world.";
    homepage = "https://blendogames.com/qc";
    license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
    mainProgram = "quadrilateralcowboy";
  };
}

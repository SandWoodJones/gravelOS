{
  lib,
  stdenv,
  requireFile,
  unzip,
  makeWrapper,
  autoPatchelfHook,
  makeDesktopItem,
  copyDesktopItems,
  SDL2,
  udev,
  alsa-lib,
  xorg,
  wget,
}:
stdenv.mkDerivation rec {
  pname = "pico8";
  version = "0.2.6b";

  src = requireFile {
    name = "pico-8_${version}_amd64.zip";
    url = "https://www.lexaloffle.com";
    hash = "sha256-fKjpAZ9zdxBkhZ9xMCu8ZcbkBCAwYF9O4vLIxOKbFdU=";
  };

  nativeBuildInputs = [
    unzip
    makeWrapper
    autoPatchelfHook
    copyDesktopItems
  ];

  buildInputs = [
    SDL2
    udev
    alsa-lib
    wget
  ] ++ (with xorg; [
    libX11
    libXext
    libXcursor
    libXinerama
    libXi
    libXrandr
    libXScrnSaver
    libXxf86vm
    libxcb
    libXrender
    libXfixes
    libXau
    libXdmcp
  ]);

  desktopItems = [
    (makeDesktopItem {
      name = "pico8";
      desktopName = "PICO-8";
      exec = "pico8 %f";
      icon = "pico8";
      mimeTypes = [ "application/x-pico8-cart" ];
      categories = [ "Game" ];
    })
  ];

  installPhase = ''
    install -Dm755 pico8 $out/libexec/pico8/pico8
    install -Dm644 pico8.dat $out/libexec/pico8/pico8.dat
    install -Dm755 pico8_dyn $out/libexec/pico8/pico8_dyn

    install -Dm644 lexaloffle-pico8.png $out/share/icons/hicolor/128x128/apps/pico8.png
    install -Dm644 license.txt $out/share/licenses/pico8/LICENSE
    install -Dm644 pico-8_manual.txt $out/share/doc/pico8/manual.txt
    install -Dm644 readme_linux.txt $out/share/doc/pico8/README

    install -Dm644 ${./mimetype.xml} $out/share/mime/packages/application-x-pico8-cart.xml
    
    runHook postInstall
  '';

  postFixup = ''
    makeWrapper $out/libexec/pico8/pico8 $out/bin/pico8 \
      --set LD_LIBRARY_PATH "${lib.makeLibraryPath buildInputs}" \
      --set PATH "${lib.makeBinPath [ wget ]}"
  '';

  meta = {
    description = "Fantasy console for making, sharing and playing tiny games and other computer programs.";
    homepage = "https://www.lexaloffle.com/pico-8.php";
    license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
    mainProgram = "pico8";
  };
}

{ stdenv, pkgs, lib, SDL2, ... }: stdenv.mkDerivation rec {
  pname = "pico8";
  version = "0.2.6b";

  src = pkgs.requireFile {
    name = "pico-8_${version}_amd64.zip";
    url = "https://www.lexaloffle.com";
    hash = "sha256-fKjpAZ9zdxBkhZ9xMCu8ZcbkBCAwYF9O4vLIxOKbFdU=";
  };

  nativeBuildInputs = with pkgs; [ unzip copyDesktopItems makeWrapper patchelf ];

  desktopItems = [
    (pkgs.makeDesktopItem {
      name = "pico8";
      desktopName = "PICO-8";
      exec = "pico8 %f";
      icon = "pico8";
      mimeTypes = ["application/x-pico8-cart"];
    })
  ];

  inherit SDL2;

  SDL_LOAD = with pkgs.xorg; [
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
  ] ++ [ pkgs.udev pkgs.alsa-lib ];
  
  LD_LIBRARY_PATH = "${lib.makeLibraryPath SDL_LOAD}";

  unpackPhase = ''
    unzip -j $src
  '';

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/pico8
    mkdir -p $out/share/applications
    mkdir -p $out/share/mime/packages
    mkdir -p $out/share/icons/hicolor/128x128/apps
    mkdir -p $out/share/licenses/pico8
    mkdir -p $out/share/doc/pico8

    cp pico8 pico8.dat pico8_dyn $out/share/pico8
    cp ${./mimetype.xml} $out/share/mime/packages/application-x-pico8-cart.xml 
    cp lexaloffle-pico8.png $out/share/icons/hicolor/128x128/apps/pico8.png
    cp license.txt $out/share/licenses/pico8
    cp pico-8_manual.txt readme_linux.txt $out/share/doc/pico8

    makeWrapper $out/share/pico8/pico8 $out/bin/pico8 \
      --set LD_LIBRARY_PATH "${LD_LIBRARY_PATH}" \
      --prefix PATH : ${lib.makeBinPath [ pkgs.wget ]}

    copyDesktopItems
  '';

  preFixup = ''
    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $out/share/pico8/pico8
  '';
}

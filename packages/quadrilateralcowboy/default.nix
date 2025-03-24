# TODO: change to standard nixpkgs format

{ stdenv, pkgs, ... }: stdenv.mkDerivation {
  pname = "quadrilateralcowboy";
  version = "1.0";

  src = pkgs.requireFile {
    name = "quadrilateralcowboy-linux.zip";
    url = "https://blendogames.itch.io/quadrilateralcowboy";
    hash = "sha256-uQ6Y0BMO2kogFaPCHJ+ygY5lpYN+GGDTMZU+8cC0Fe4=";
  };

  nativeBuildInputs = with pkgs; [
    unzip
    autoPatchelfHook
    copyDesktopItems
    imagemagick
  ];

  buildInputs = with pkgs; [
    gcc-unwrapped
    SDL2
    openal
    libGL
  ];

  desktopItems = [
    (pkgs.makeDesktopItem {
      name = "quadrilateralcowboy";
      desktopName = "Quadrilateral Cowboy";
      exec = "quadrilateralcowboy";
      icon = "quadrilateralcowboy";
      categories = [ "Game" ];
    })
  ];

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/applications
    mkdir -p $out/share/icons/hicolor/128x128/apps

    cp qc.bin.x86_64 $out/bin/quadrilateralcowboy
    cp -r base $out/bin/

    convert Icon.bmp $out/share/icons/hicolor/128x128/apps/quadrilateralcowboy.png

    copyDesktopItems
  '';

  
  postFixup = ''
    patchelf --add-needed ${pkgs.libGL}/lib/libGL.so.1 $out/bin/quadrilateralcowboy
  '';
}

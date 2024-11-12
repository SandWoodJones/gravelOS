{ channels, ... }: _: prev:
let
  qt6 = channels.nixpkgs.qt6;
in {
  nifskope = prev.nifskope.overrideAttrs (oldAttrs: rec {
    version = "v2.0.dev9-20241028";
    src = prev.fetchgit {
      url = "https://github.com/fo76utils/nifskope";
      rev = version;
      hash = "sha256-++Jf3dTdNeQmPIhxyAiwGd4bLqFyKty217/uFSWczng=";
      fetchSubmodules = true;
    };

    patches = [ ./fixed-mime-types.patch ];

    buildInputs = with qt6; [ qtbase qtwayland qt5compat ];
    nativeBuildInputs = with qt6; [ qmake wrapQtAppsHook ];

    installPhase = ''
      runHook preInstall

      d=$out/share/nifskope
      mkdir -p $out/bin $out/share/applications $out/share/pixmaps $out/share/mime/packages $d/{shaders,lang}
      cp release/NifSkope $out/bin/
      cp ./res/nifskope.png $out/share/pixmaps/
      cp release/{nif.xml,kfm.xml,style.qss} $d/
      cp res/shaders/*.frag res/shaders/*.prog res/shaders/*.vert $d/shaders/
      cp ./res/lang/*.ts ./res/lang/*.tm $d/lang/
      cp ./install/linux-install/nifskope.desktop $out/share/applications
      cp ./install/linux-install/*.xml $out/share/mime/packages

      substituteInPlace $out/share/applications/nifskope.desktop \
        --replace 'Exec=nifskope' "Exec=$out/bin/NifSkope" \
        --replace 'Icon=nifskope' "Icon=$out/share/pixmaps/nifskope.png"

      find $out/share -type f -exec chmod -x {} \;

      runHook postInstall
    '';
  });
}

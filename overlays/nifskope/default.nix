_: _: prev: {
  nifskope = prev.nifskope.overrideAttrs (oldAttrs: rec {
    version = "v2.0.dev9-20241228";
    src = prev.fetchgit {
      url = "https://github.com/fo76utils/nifskope";
      rev = version;
      hash = "sha256-VhOnRmutR6QBRR3XnV5flEyOdXhYqiD8ARUQc6GHsMA=";
      fetchSubmodules = true;
    };

    patches = [ ./fixed-mime-types.patch ];

    buildInputs = with prev.qt6; [
      qtbase
      qtwayland
      qt5compat
    ];
    nativeBuildInputs = with prev.qt6; [
      qmake
      wrapQtAppsHook
    ];

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

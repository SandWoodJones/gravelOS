{ pkgs, makeDesktopItem, copyDesktopItems, ... }: pkgs.python3Packages.buildPythonApplication {
  pname = "UnsupOpen";
  version = "0.1.0";
  src = ./.;

  nativeBuildInputs = [ copyDesktopItems ];
  propagatedBuildInputs = with pkgs.python3Packages; [ click pillow pkgs.perl540Packages.FileMimeInfo ];

  desktopItems = [
    (makeDesktopItem {
      name = "unsup-open";
      desktopName = "UnsupOpen";
      exec = "unsup-open %f";
      mimeTypes = ["image/x-dds"];
      startupNotify = false;
      noDisplay = true;
    })
  ];

  meta = {
    description = "Tool for opening unsupported image files on your default image viewing application";
  };
}

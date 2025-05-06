# TODO: write in standard nixpkgs format, add meta, and make a pull request
{ stdenv, pkgs, ... }:
stdenv.mkDerivation rec {
  pname = "umbrello";
  version = "v24.12.3";

  src = pkgs.fetchgit {
    url = "https://invent.kde.org/sdk/umbrello.git";
    rev = version;
    hash = "sha256-MMCxbqmThzUUewzxG65VtjEQ83lF3GYOZmYO/oWLwM8=";
  };

  buildInputs = with pkgs.libsForQt5; [
    qt5.qtbase
    qt5.qtsvg

    karchive
    kcompletion
    kcoreaddons
    kcrash
    kdoctools
    kiconthemes
    kio
    ktexteditor
  ];

  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
    extra-cmake-modules
    libsForQt5.qt5.wrapQtAppsHook
    libsForQt5.kdoctools
  ];
}

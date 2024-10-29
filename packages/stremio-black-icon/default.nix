{ pkgs, ... }: pkgs.stremio.overrideAttrs (prev: {
  pname = "stremio-shell-black-icon";
  patches = (prev.patches or []) ++ [ ./black-tray-icon.patch ];
})

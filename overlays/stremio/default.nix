_: _: prev: {
  stremio = prev.stremio.overrideAttrs (oldAttrs: {
    postInstall = oldAttrs.postInstall + ''
      mv $out/share/applications/smartcode-stremio.desktop $out/share/applications/com.stremio.stremio.desktop
    '';
  });
}

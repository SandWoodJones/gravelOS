{ ... }: _: prev: {
  stremio = prev.stremio.overrideAttrs (oldAttrs: {
    postInstall = ''
      ${oldAttrs.postInstall or ""}
      mv $out/share/applications/smartcode-stremio.desktop $out/share/applications/com.stremio.stremio.desktop
    '';
  });
}

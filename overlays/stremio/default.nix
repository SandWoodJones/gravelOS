{ useBlackIcon ? true, ... }: final: prev: {
  stremio = prev.stremio.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or []) ++ prev.lib.optional useBlackIcon ./black-tray-icon.patch;
  
    postInstall = ''
      ${oldAttrs.postInstall or ""}
      mv $out/share/applications/smartcode-stremio.desktop $out/share/applications/com.stremio.stremio.desktop
    '';
  });
}

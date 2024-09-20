{ ... }: final: prev: {
  trashy = prev.trashy.overrideAttrs (oldAttrs: rec {
    postInstall = ''
      ${oldAttrs.postInstall}
      $out/bin/trash manpage > trashy.1
      ln -s trashy.1 trash.1
      installManPage trashy.1 trash.1
    '';
  });
}

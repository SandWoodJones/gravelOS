{ ... }: final: prev: {
  trashy = prev.trashy.overrideAttrs (oldAttrs: {
    postInstall = ''
      ${oldAttrs.postInstall}
      $out/bin/trash manpage > trashy.1
      ln -s trashy.1 trash.1
      installManPage trashy.1 trash.1
    '';
  });
}

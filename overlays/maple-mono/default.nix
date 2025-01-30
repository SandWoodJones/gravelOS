# TODO: submit pull request to nixpkgs
{ ... }: _: prev: {
  maple-mono = prev.maple-mono.overrideAttrs (oldAttrs: {
    version = "7.0b36";
    src = prev.fetchurl {
      url = "https://github.com/subframe7536/maple-font/releases/download/v7.0-beta36/MapleMonoNormal-Variable.zip";
      hash = "sha256-DT/OL8yjhV+jXpIjzc6+nSiYNJY27SWQx9fbXXvc5k4=";
    };

    installPhase = ''
      install -Dt $out/share/fonts/truetype *.ttf
    '';
  });
}

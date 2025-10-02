# NOTE: maybe replace base16 with own implementation https://github.com/mxxntype/Aeon-snowfall
# TODO: configure `ov`, `tealdeer`, `eza` (https://github.com/eza-community/eza/blob/main/docs/theme.yml), `gitui`

{
  inputs,
  ...
}:
{
  mkScheme =
    pkgs:
    let

      base16lib = inputs.base16.lib {
        inherit pkgs;
        lib = pkgs.lib;
      };

      molokai-edited = (base16lib.mkSchemeAttrs "${inputs.tt-schemes}/base24/molokai.yaml").override {
        slug = "molokai-edited";
        base05 = "ffffff";
      };
    in
    molokai-edited;
}

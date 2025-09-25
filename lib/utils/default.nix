{
  lib,
  ...
}:
{
  hasElement =
    extractor: target: list:
    builtins.any (elem: extractor elem == target) list;

  filterAttrs = attrSet: keys: builtins.filter (key: builtins.hasAttr key attrSet) keys;

  connectLists =
    attrSet: toList: builtins.concatLists (builtins.attrValues (builtins.mapAttrs (_: toList) attrSet));

  mkEnableDefault = name: lib.mkEnableOption name // { default = true; };
}

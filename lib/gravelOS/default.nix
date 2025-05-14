{ ... }:
{
  hasElement = extractor: target: list:
    builtins.any (elem: extractor elem == target) list;

  filterAttrs = attrSet: keys:
    builtins.filter (key: builtins.hasAttr key attrSet) keys;
}

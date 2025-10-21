{
  lib,
  ...
}:
rec {
  # clamp :: number -> number -> number -> number
  # arguments:
  #   val: value to clamp
  #   low: minimum limit
  #   high: maximum limit
  # Clamps a value between the given lower and upper bounds
  clamp =
    val: low: high:
    if val < low then
      low
    else if val > high then
      high
    else
      val;

  # lerp :: [number] -> [number] -> number -> [number]
  # arguments:
  #   start: starting values list
  #   end: ending values list
  #   factor: interpolation factor in [0.0, 1.0]
  # Performs linear interpolation between 2 lists of the same size. If the sizes aren't the same the interpolation stops at the shortest.
  lerp =
    start: end: factor:
    lib.zipListsWith (a: b: a + (b - a) * factor) start end;

  # hasElement :: (a -> b) -> b -> [a] -> bool
  # arguments:
  #   extractor: function used to extract a comparable value from each list element
  #   target: value to search for
  #   list: list to be searched
  # Checks whether any element in the list matches the target after applying the extractor
  hasElement =
    extractor: target: list:
    builtins.any (elem: extractor elem == target) list;

  # existingKeys :: attrset -> [string] -> [string]
  # arguments:
  #   attrSet: attribute set to check
  #   keys: list of attribute names to filter
  # Returns a list of keys that exist in the given attribute set
  existingKeys = attrSet: keys: builtins.filter (key: builtins.hasAttr key attrSet) keys;

  # connectLists :: attrset -> (a -> [b]) -> [b]
  # arguments:
  #   attrSet: attribute set to transform
  #   toList: function that maps each attribute value to a list
  # Concatenates all lists returned by applying `toList` to each value in the attribute set
  connectLists =
    attrSet: toList: builtins.concatLists (builtins.attrValues (builtins.mapAttrs (_: toList) attrSet));

  # mkEnableDefault :: string -> option
  # arguments:
  #   name: name of the option to create
  # Creates a NixOS option enabled by default using lib.mkEnableOption
  mkEnableDefault = name: lib.mkEnableOption name // { default = true; };

  # mkAttrsFlatStr :: { isLeaf :: a -> bool, prefix :: string } -> attrset -> attrset
  # arguments:
  #   isLeaf: (optional) function that returns true if a value should be treated as a leaf node. Defaults to (v: false)
  #   prefix: (optional) initial path prefix. Defaults to ""
  #   attrs: attribute set to flatten
  # Flattens a nested attribute set into a single-level set with dot-separated keys
  mkAttrsFlatStr =
    {
      isLeaf ? (_: false),
      prefix ? "",
    }:
    attrs:
    builtins.foldl' (
      acc: key:
      let
        value = attrs.${key};
        path = if prefix == "" then key else "${prefix}.${key}";

        isDefaultLeaf =
          v: (builtins.isFunction v) || (builtins.isAttrs v && v ? "type" && v.type == "derivation");
      in
      acc
      // (
        if builtins.isAttrs value && !isDefaultLeaf value && !isLeaf value then
          mkAttrsFlatStr {
            inherit isLeaf;
            prefix = path;
          } value
        else
          { ${path} = value; }
      )
    ) { } (builtins.attrNames attrs);
}

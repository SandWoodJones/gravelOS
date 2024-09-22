{ config, ... } :
  # taken from github.com/mxxntype/Aeon-snowfall
  let ifPresent = groups: builtins.filter (G: builtins.hasAttr G config.users.groups) groups;

  in {
    config = {
      users.users.swj = {
        isNormalUser = true;
        description = "SandWood Jones";
        useDefaultShell = true;
        extraGroups = [
          "wheel"
          "video"
        ] ++ ifPresent [
          "networkmanager"   
        ];
      };
  };
}

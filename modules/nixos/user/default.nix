{ config, inputs, ... } :
  # taken from github.com/mxxntype/Aeon-snowfall
  let ifPresent = groups: builtins.filter (G: builtins.hasAttr G config.users.groups) groups;
  in {
    config = {
      sops.secrets.swj-password.neededForUsers = true;

      users = {
        mutableUsers = false;        
        
        users.root.hashedPasswordFile = config.sops.secrets.swj-password.path;
        users.swj = {
          isNormalUser = true;
          description = "SandWood Jones";
          hashedPasswordFile = config.sops.secrets.swj-password.path;
          openssh.authorizedKeys.keys = [ (builtins.readFile "${inputs.self}/lib/id_swj.pub") ];
          useDefaultShell = true;
          extraGroups = [
            "wheel"
            "video"
          ] ++ ifPresent [
            "networkmanager"   
          ];
        };
      };
    };
}

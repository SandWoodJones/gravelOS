{ config, inputs, ... } :
# taken from github.com/mxxntype/Aeon-snowfall
let
  ifPresent = groups: builtins.filter (G: builtins.hasAttr G config.users.groups) groups;
  sshKeysPath = "${inputs.self}/lib/keys";
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
        openssh.authorizedKeys.keyFiles = [
          "${sshKeysPath}/id_swj.pub"
          "${sshKeysPath}/id_nixOS_secrets.pub"
        ];
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

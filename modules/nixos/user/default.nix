{ config, inputs, ... } :
# taken from github.com/mxxntype/Aeon-snowfall
let
  ifPresent = groups: builtins.filter (G: builtins.hasAttr G config.users.groups) groups;
  sshKeysPath = "${inputs.self}/lib/keys";
in {
  config = {
    users = {
      users.swj = {
        isNormalUser = true;
        description = "SandWood Jones";
        openssh.authorizedKeys.keyFiles = [ "${sshKeysPath}/id_swj.pub" ];
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

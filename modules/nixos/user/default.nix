{ lib, config, inputs, ... } :
let
  # taken from github.com/mxxntype/Aeon-snowfall
  ifPresent = groups: builtins.filter (G: builtins.hasAttr G config.users.groups) groups;
  sshKeysPath = "${inputs.self}/lib/keys";

  cfg = config.gravelOS.user;
in {
  options.gravelOS.user.createSWJ = lib.mkOption {
    default = false;
    example = true;
    description = "Whether gravelOS should create the SandWood Jones user.";
    type = lib.types.bool;
  };

  config = {
    users = {
      users.swj = lib.mkIf cfg.createSWJ {
        isNormalUser = true;
        description = "SandWood Jones";
        openssh.authorizedKeys.keyFiles = [ "${sshKeysPath}/id_swj.pub" ];
        useDefaultShell = true;
        extraGroups = [
          "wheel"
          "video"
        ] ++ ifPresent [
          "networkmanager"
          "gamemode"
        ];
      };
    };
  };
}

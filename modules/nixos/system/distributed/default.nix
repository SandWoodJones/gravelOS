# TODO: make this way more robust

{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.system.distributed;
in
{
  options.gravelOS.system.distributed = {
    builder.enable = lib.mkEnableOption "acting as the builder machine for distributed builds";
    client.enable = lib.mkEnableOption "support for delegating building to remote builder machines";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.builder.enable {
      users = {
        groups.nixbuilder = { };
        users.builder = {
          isSystemUser = true;
          group = "nixbuilder";
          shell = pkgs.bash;
          home = "/var/lib/builder";
          createHome = true;
          openssh.authorizedKeys.keyFiles = config.gravelOS.system.user.authorizedKeyFiles;
        };
      };
      nix.settings.trusted-users = [ "builder" ];
    })

    (lib.mkIf cfg.client.enable {
      nix = {
        distributedBuilds = true;
        buildMachines = [
          {
            hostName = "clay.local";
            system = "x86_64-linux";
            protocol = "ssh-ng";
            sshUser = "builder";
            sshKey = "/etc/ssh/ssh_host_ed25519_key";
            supportedFeatures = [
              "benchmark"
              "big-parallel"
              "kvm"
              "nixos-test"
            ];
            maxJobs = 24;
            speedFactor = 2;
          }
        ];
        settings.builders-use-substitutes = true;
      };
    })
  ];
}

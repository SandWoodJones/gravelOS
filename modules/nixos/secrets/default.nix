_: {
  sops = {
    defaultSopsFile = ../../../secrets.yaml;
    validateSopsFiles = false;

    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    secrets = {
      root-password = { neededForUsers = true; };
      swj-password = { neededForUsers = true; };
      syncthing-password = {};
    };
  };
}

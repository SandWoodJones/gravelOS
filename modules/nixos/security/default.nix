{ config, pkgs, ... }: {
  config = {
    services.openssh.enable = true;
    programs.ssh.startAgent = true;
    programs.gnupg.agent = {
      enable = true;
      enableBrowserSocket = true;
    };

    environment.systemPackages = [ pkgs.age ];
  };
}

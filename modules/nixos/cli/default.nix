{ pkgs, ... }: {
  config = {
    users.defaultUserShell = pkgs.zsh;

    programs = {
      direnv = { enable = true; silent = true; };
      command-not-found.enable = false;
      nix-index.enable = true;
    };
 
    environment = {
      systemPackages = with pkgs; [
        helix
        file
        trashy
        fzf
        eza
        ov
        jre_minimal
        p7zip
      ];

      variables = {
        GRAVELOS_PATH = "/home/swj/projects/gravelOS";
        EDITOR = "${pkgs.helix}/bin/hx";
        PAGER = "${pkgs.ov}/bin/ov-less";
      };
    };
  };
}

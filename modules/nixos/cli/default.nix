{ pkgs, ... }: {
  config = {
    users.defaultUserShell = pkgs.zsh;

    programs.direnv = { enable = true; silent = true; };
 
    environment = {
      systemPackages = with pkgs; [
        helix
        file
        trashy
        fzf
        eza
        ov
        jre_minimal
      ];

      variables = {
        GRAVELOS_PATH = "/home/swj/projects/gravelOS";
        EDITOR = "${pkgs.helix}/bin/hx";
        PAGER = "${pkgs.ov}/bin/ov-less";
      };
    };
  };
}

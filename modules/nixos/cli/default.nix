{ pkgs, inputs, ... }: {
  config = {
    programs.direnv = { enable = true; silent = true; };
  
    environment = {
      systemPackages = with pkgs; [
        helix
        file trashy
        fzf eza
        ov
      ];

      shellAliases = {
        sus = "systemctl --user";
        clearx = "clear -x";
        gs = "git status";

        ls = "eza";
        tree = "eza -T --git-ignore";
  
        # Disable rm in favor of using trashy
        rm = "printf \"\\e[31mCommand not executed\\e[0m\\n\"";
        tp = "trash put";

        nix = "noglob nix"; # Disable globbing when running nix commands so that .#~ doesn't fail
      };

      variables = {
        GRAVELOS_PATH = "${inputs.self}";
        EDITOR = "${pkgs.helix}/bin/hx";
        PAGER = "${pkgs.ov}/bin/ov-less";
      };
    };
  };
}

{ lib, config, pkgs, ... }: {
  options.gravelOS.nh-clean.enable = lib.mkOption {
    description = "Whether to enable nh's periodic garbage collection";
    type = lib.types.bool;
    default = true;
  };

  config = {
    documentation = {
      dev.enable = true;
      man.generateCaches = true;
    };

    programs.nh = {
      enable = true;
      clean = {
        enable = config.gravelOS.nh-clean.enable;
        extraArgs = "--keep 10 --keep-since 10d";
      };
    };

    programs.git = {
      enable = true;
      # https://jvns.ca/blog/2024/02/16/popular-git-config-options/
      config = {
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        merge.conflictStyle = "zdiff3";
        commit.verbose = true;
        rerere.enabled = true;
        diff.algorithm = "histogram";
        url."git@github.com:".insteadOf = [ "https://github.com/" ];
        branch.sort = "-committerdate";

        core.pager = "${pkgs.delta}/bin/delta";
        interactive.diffFilter = "${pkgs.delta}/bin/delta --color-only";
        delta.navigate = true;

        transfer.fsckObjects = true;
        fetch.fsckObjects = true;
        receive.fsckObjects = true;
      };
    };

    programs.direnv = { enable = true; silent = true; };
    programs.thefuck.enable = true;

    environment = {
      systemPackages = with pkgs; [
        helix
        wl-clipboard
        file trashy
        fzf
        ov
      ];
    
      shellAliases = {
        # Disable rm in favor of using trashy
        rm = "printf \"\\e[31mCommand not executed\\e[0m\\n\"";
        tp = "trash put";
      };

      variables = {
        EDITOR = "${pkgs.helix}/bin/hx";
        PAGER = "${pkgs.ov}/bin/ov-less";
      };
    };
  };
}

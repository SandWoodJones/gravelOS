{ lib, config, pkgs, ... }: {
  config = {
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
        url."git@github.com:".insteadOf = lib.mkIf (!config.gravelOS.networking.wifi.enable) [ "https://github.com/" ];
        branch.sort = "-committerdate";

        core.pager = "${pkgs.delta}/bin/delta";
        interactive.diffFilter = "${pkgs.delta}/bin/delta --color-only";
        delta.navigate = true;

        transfer.fsckObjects = true;
        fetch.fsckObjects = true;
        receive.fsckObjects = true;

        alias = {
          df = "diff";
          dfs = "diff --staged";
        };

        credential."https://github.com".helper = "!${pkgs.gh}/bin/gh auth git-credential";
        credential."https://gist.github.com".helper = "!${pkgs.gh}/bin/gh auth git-credential";
      };
    };

    environment.systemPackages = [ pkgs.gh ];
  };
}

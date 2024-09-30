{ config, pkgs, ... }: {
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

      alias = {
        s = "status";
        d = "diff";
        ds = "diff --staged";
      };
    };
  };
}

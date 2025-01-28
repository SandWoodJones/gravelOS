{ pkgs, lib, config, ... }:
let
  cfg = config.gravelOS.git;
in {
  options.gravelOS.git = {
    enable = lib.mkEnableOption "git functionality";
    enableConfig = lib.mkOption {
      default = false;
      example = true;
      description = "Whether to enable gravelOS's git configuration.";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.gh ];
    programs.git = {
      enable = true;

      # https://jvns.ca/blog/2024/02/16/popular-git-config-options/
      config = lib.mkIf cfg.enableConfig {
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        merge.conflictStyle = "zdiff3";
        commit.verbose = true;
        rerere.enabled = true;
        diff.algorithm = "histogram";
        branch.sort = "-committerdate";

        # TODO: configure delta
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

        url."git@github.com:".insteadOf = lib.mkIf (!config.gravelOS.networking.wifi.enable) [ "https://github.com/" ];
        credential."https://github.com".helper = "!${pkgs.gh}/bin/gh auth git-credential";
        credential."https://gist.github.com".helper = "!${pkgs.gh}/bin/gh auth git-credential";
      };
    };
  };
}

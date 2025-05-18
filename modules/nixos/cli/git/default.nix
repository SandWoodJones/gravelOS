# TODO: configure delta
# TODO: replace meld with git diffuse or helix if https://github.com/helix-editor/helix/issues/5132 ever gets implemented.

{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.cli.git;
in
{
  options.gravelOS.cli.git = {
    delta.enable = lib.mkEnableOption "delta as git's pager.";
  };

  config = {
    programs.git = {
      enable = true;

      config = lib.mkMerge [
        {
          init.defaultBranch = "main";
          push.autoSetupRemote = true;
          merge.conflictStyle = "zdiff3";
          commit.verbose = true;
          rerere.enabled = true;
          diff.algorithm = "histogram";
          branch.sort = "-committerdate";

          transfer.fsckObjects = true;
          fetch.fsckObjects = true;
          receive.fsckObjects = true;

          alias = {
            df = "diff";
            dfs = "diff --staged";
          };
        }

        (lib.mkIf cfg.delta.enable {
          core.pager = "${pkgs.delta}/bin/delta";
          interactive.diffFilter = "${pkgs.delta}/bin/delta --color-only";
          delta.navigate = true;
        })
      ];
    };

    environment.systemPackages = [ pkgs.meld ];
  };
}

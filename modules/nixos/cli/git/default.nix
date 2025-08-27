# TODO: replace meld with git diffuse or helix if https://github.com/helix-editor/helix/issues/5132 ever gets implemented.

{
  pkgs,
  ...
}:
{
  programs.git = {
    enable = true;

    config = {
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
    };
  };

  environment.systemPackages = [ pkgs.meld ];
}

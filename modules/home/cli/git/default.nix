# TODO: look into gh settings and zextensions
# TODO: configure gitui
# TODO: configure delta

{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.cli.git;
  rebaseStash = pkgs.writeShellScript "git-stash-rb" ''
    set -eu
    git stash push --keep-index -m "unstaged"
    git stash push -m "staged"
  '';
in
{
  options.gravelOS.cli.git = {
    username = lib.mkOption {
      default = "SandWood Jones";
      example = "John Doe";
      description = "The Git username used for authoring commits.";
      type = lib.types.str;
    };
    email = lib.mkOption {
      default = "sandwoodjones@outlook.com";
      example = "johndoe@email.com";
      description = "The Git email used for authoring commits.";
      type = lib.types.str;
    };

    signing.ssh = {
      enable = lib.mkEnableOption "signing commits with SSH";
      keyPath = lib.mkOption {
        default = null;
        example = "/home/username/.ssh/id_key";
        description = "The path to the SSH private key used for signing commits.";
        type = lib.types.path;
      };
    };
  };

  config = {
    gravelOS.system.networking.ssh.git.enable = lib.mkDefault true;

    programs = {
      git = {
        enable = true;
        settings = lib.mkMerge [
          {
            user = {
              inherit (cfg) email;
              name = cfg.username;
              signingKey = builtins.toString cfg.signing.ssh.keyPath;
            };

            alias = {
              df = "diff";
              dfs = "diff --staged";
              rbi = "rebase --interactive";
              rbc = "rebase --continue";
              rbs = "!${rebaseStash}";
              pop = "stash pop";
            };
          }

          (lib.mkIf cfg.signing.ssh.enable {
            gpg.format = "ssh";
            commit.gpgSign = true;
          })
        ];
      };

      delta = {
        enable = true;
        enableGitIntegration = true;
        options = {
          navigate = true;
          side-by-side = true;
        };
      };

      gh.enable = true;

      gitui = {
        enable = true;
        keyConfig = builtins.readFile ./gitui_vim.ron;
      };
    };
  };
}

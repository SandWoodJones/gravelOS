# TODO: look into gh settings and zextensions
# TODO: configure gitui
# TODO: configure delta

{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.cli.git;
in
{
  options.gravelOS.cli.git = {
    username = lib.mkOption {
      default = "SandWood Jones";
      description = "The Git username used for authoring commits.";
      type = lib.types.str;
    };
    email = lib.mkOption {
      default = "sandwoodjones@outlook.com";
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

    delta.enable = lib.mkEnableOption "delta syntax highlighter";
  };

  config = {
    gravelOS.system.networking.ssh.git.enable = lib.mkDefault true;

    programs = {
      git = {
        enable = true;
        extraConfig = lib.mkMerge [
          {
            user = {
              inherit (cfg) email;

              name = cfg.username;
              signingKey = builtins.toString cfg.signing.ssh.keyPath;
            };
          }

          (lib.mkIf cfg.signing.ssh.enable {
            gpg.format = "ssh";
            commit.gpgSign = true;
          })
        ];

        aliases = {
          df = "diff";
          dfs = "diff --staged";
          rbi = "rebase --interactive";
          rbc = "rebase --continue";
        };

        delta = lib.mkIf cfg.delta.enable {
          enable = true;
          options = {
            navigate = true;
            side-by-side = true;
          };
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

{ lib, config, osConfig, ... }:
let
  cfg = config.gravelOS.git;
in {
  options.gravelOS.git = {
    enable = lib.mkEnableOption "git and git tools";
    enableConfig = lib.mkOption {
      default = false;
      example = true;
      description = "Whether to enable gravelOS's git configuration.";
      type = lib.types.bool;
    };
  };
  
  config = lib.mkIf cfg.enable {
    programs = {
      git = {
        enable = true;
        extraConfig = lib.mkIf cfg.enableConfig (lib.mkMerge [
          { user.name = "SandWood Jones"; user.email = "sandwoodjones@outlook.com"; }
          (lib.mkIf osConfig.gravelOS.system.networking.ssh.enable {
            user.signingKey = "${config.home.homeDirectory}/.ssh/id_swj";
            gpg.format = "ssh";
            commit.gpgSign = true;
          })
        ]);
      };

      # TODO: look into gh settings and extensions
      gh.enable = true;

      gitui = {
        enable = true;
        keyConfig = builtins.readFile ./gitui_vim.ron;
      };
    };
  };
}

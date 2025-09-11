# NOTE: forever try to clean the home directory as much as possible (https://wiki.archlinux.org/title/XDG_Base_Directory)

{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.system.xdg;
in
{
  options.gravelOS.system.xdg = {
    defaultBaseDirs.enable = lib.mkOption {
      default = false;
      example = true;
      description = "Whether to disable some XDG base home directories and rename the others as lowercase.";
      type = lib.types.bool;
    };
  };

  config = {
    home = {
      preferXdgDirectories = true;
      sessionVariables = {
        XCOMPOSECACHE = "${config.xdg.cacheHome}/X11/xcompose";
        ERRFILE = "${config.xdg.cacheHome}/X11/xsession-errors";
        GTK2_RC_FILES = "${config.xdg.configHome}/gtk-2.0/gtkrc";
        "_JAVA_OPTIONS" = "-Djava.util.prefs.userRoot=${config.xdg.configHome}/java";
        CARGO_HOME = "${config.xdg.dataHome}/cargo";
        DOCKER_CONFIG = "${config.xdg.configHome}/docker";
        PYTHON_HISTORY = "${config.xdg.dataHome}/python_history";
        PSQL_HISTORY = "${config.xdg.stateHome}/psql_history";
        NODE_REPL_HISTORY = "${config.xdg.stateHome}/node_repl_history";
        NPM_CONFIG_INIT_MODULE = "${config.xdg.configHome}/npm/config/npm-init.js";
        NPM_CONFIG_CACHE = "${config.xdg.cacheHome}/npm";
        NPM_CONFIG_TMP = "$XDG_RUNTIME_DIR/npm";
        DOTNET_CLI_HOME = "${config.xdg.dataHome}/dotnet";
        GRADLE_USER_HOME = "${config.xdg.dataHome}/gradle";
        ANDROID_USER_HOME = "${config.xdg.dataHome}/android";
      };
    };

    xdg = lib.mkIf cfg.defaultBaseDirs.enable {
      enable = true;
      userDirs = {
        enable = true;
        createDirectories = true;
        desktop = "${config.home.homeDirectory}/desktop";
        documents = "${config.home.homeDirectory}/documents";
        download = "${config.home.homeDirectory}/downloads";
        pictures = "${config.home.homeDirectory}/media/pictures";
        videos = "${config.home.homeDirectory}/media/videos";
        music = null;
        publicShare = null;
        templates = null;
      };
    };
  };
}

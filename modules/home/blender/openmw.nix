{ lib, config, pkgs, ... }:
let
  cfg = config.gravelOS.desktop;
  enabled = (cfg.enable && cfg.blender.enable && cfg.gaming.openMW.enable);

  enableScript = pkgs.writeShellScript "enable-io_scene_mw" ''
    echo '
    import bpy
    addon_name = "bl_ext.user_default.io_scene_mw"
    if addon_name not in bpy.context.preferences.addons: bpy.ops.preferences.addon_enable(module=addon_name)
    bpy.ops.wm.save_userpref()
    ' > /tmp/cmd.py

    ${pkgs.blender}/bin/blender --python /tmp/cmd.py --background

    rm /tmp/cmd.py
  '';
in {
  config = lib.mkIf enabled {
    xdg = {
      configFile = {
        "blender/4.2/extensions/user_default/io_scene_mw" = {
          source = pkgs.fetchFromGitHub {
            owner = "Greatness7";
            repo = "io_scene_mw";
            rev = "0.8.102";
            hash = "sha256-XNrQBXrYyi8lJ7R8avrQER4vjKHfNqbqjZZg1xY3nsU=";
          };

          onChange = "${enableScript}";
        };

        "blender/4.2/scripts/addons/nif-thumbnail.py".source = ./nif-thumbnail.py;        
      };

      dataFile."thumbnailers/nif.thumbnailer".text = ''
        [Thumbnailer Entry]
        Exec=${pkgs.blender}/bin/blender --factory-startup --background --python ${config.xdg.configHome}/blender/4.2/scripts/addons/nif-thumbnail.py -- %i %o %s
        MimeType=application/vnd.gamebryo-nif;
      '';
    };
  };
}

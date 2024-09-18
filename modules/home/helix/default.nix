{ lib, config, ... }: {
  options.gravelOS.helix = {
    enable = lib.mkOption {
      description = "Whether to enable HomeManager's management of the Helix editor";
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.gravelOS.helix.enable { 
    programs.helix = {
      enable = true;
      defaultEditor = true;
    };
    
    programs.helix.settings = {
      editor.cursor-shape.insert = "bar";
    };
  };
}

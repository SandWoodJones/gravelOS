{ config, ... }: {
  config = { 
    programs.helix = {
      enable = true;
      defaultEditor = true;
    };
    
    programs.helix.settings = {
      editor.cursor-shape.insert = "bar";
    };
  };
}

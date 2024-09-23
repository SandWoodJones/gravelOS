{ config, ... }: {
  config = {
    programs.zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };

    programs.tealdeer.enable = true;
  };
}

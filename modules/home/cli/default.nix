{ ... }: {
  config = {
    programs.thefuck.enable = true;
    programs.zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };

    programs.tealdeer.enable = true;
  };
}

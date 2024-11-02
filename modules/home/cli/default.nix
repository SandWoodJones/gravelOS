{ ... }: {
  config = {
    programs = {
      zoxide = {
        enable = true;
        options = [ "--cmd cd" ];
      };

      thefuck.enable = true;
      tealdeer.enable = true;
    };
  };
}

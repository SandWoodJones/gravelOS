{ lib, config, ... }: {
  options.gravelOS = {
    networking.bluetooth.mediaControls = lib.mkOption {
      description = "Whether to enable bluetooth headset buttons to control media players";
      type = lib.types.bool;
      default = false;
    };

    xdg.lowercaseDirs = lib.mkOption {
      description = "Whether to rename the default xdg-user dirs to lowercase.";
      type = lib.types.bool;
      default = true;
    };
  };

  config = {
    nix = { inherit (lib.gravelOS.nix) settings; };
  };
}

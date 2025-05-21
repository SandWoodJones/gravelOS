{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.cli.packages;
in
{
  options.gravelOS.cli.packages = {
    archive.enable = lib.mkEnableOption "archival (compression, decompression) packages";
    encryption.enable = lib.mkEnableOption "encryption packages";
  };

  config = {
    environment.systemPackages =
      with pkgs;
      builtins.concatLists [
        (lib.optionals cfg.archive.enable [
          p7zip
          unrar
          unzip
        ])
        (lib.optionals cfg.encryption.enable [
          sops
          age
          ssh-to-age
        ])
        [
          # System essentials
          file

          # User essentials
          helix
          trashy

          # Nice-to-haves
          fzf
          eza
          ov
          statix
        ]
      ];
  };
}

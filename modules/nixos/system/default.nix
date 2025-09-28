{
  lib,
  inputs,
  system,
  ...
}:
let
  needsreboot = "${inputs.nixos-needsreboot.packages.${system}.default}/bin/nixos-needsreboot";
in
{
  environment.localBinInPath = true;
  
  # https://github.com/etu/nixconfig/blob/739bd9ca4765519f7f1667d1e71f6051661b9b4d/modules/base/default.nix#L87-L102
  system.activationScripts.rebootCheck = {
    supportsDryActivation = true;
    text = ''
      ${needsreboot} 2>&1 | while IFS= read -r line; do
        if [[ "$line" == DEBUG:* ]]; then
          echo "$line"
        else
          echo -e "\033[33m$line\033[0m"
        fi
      done || true
    '';
  };

  programs.java = {
    enable = true;
    binfmt = true;
  };

  gravelOS.system = {
    networking = {
      wifi.enable = lib.mkDefault true;
      ssh.enable = lib.mkDefault true;
    };

    audio.enable = true;
  };
}

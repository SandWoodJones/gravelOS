{ lib, config, ... }:
let
  cfg = config.gravelOS.hyprland;
in {
  options.gravelOS.hyprland.enable = lib.mkEnableOption "Hyprland";

  config = lib.mkIf cfg.enable {
    assertions = [{ assertion = config.gravelOS.display.enable; message = "you must have graphical display support enabled to use Hyprland"; }];

    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };

    # TODO: replace kwallet with gnome-keyring  
    # services.gnome.gnome-keyring.enable = true;
    # security.pam.services.gdm-password.enableGnomeKeyring = true; #https://discourse.nixos.org/t/login-keyring-did-not-get-unlocked-hyprland/40869/12

    hardware.brillo.enable = true;
    services.playerctld.enable = true;

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}

{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.system.hyprland;
in
{
  options.gravelOS.system.hyprland = {
    hyprpolkit.enable = lib.mkEnableOption "Hyprland Polkit Authentication Agent";
  };

  config = {
    gravelOS.system.hyprland.hyprpolkit.enable = lib.mkDefault true;
  
    services.hyprpolkitagent.enable = cfg.hyprpolkit.enable;
    systemd.user.services.hyprpolkitagent = lib.mkIf cfg.hyprpolkit.enable {
      Install.WantedBy = lib.mkForce [ "wayland-session@Hyprland.target" ];
      Unit = {
        PartOf = lib.mkForce [ "wayland-session@Hyprland.target" ];
        After = lib.mkForce [ "wayland-session@Hyprland.target" ];
      };
    };
  };
}

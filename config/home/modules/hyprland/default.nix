{ pkgs, lib, config, ... }:
let
  waybar-experimental = pkgs.waybar.overrideAttrs (oldAttrs: {
    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  });

  cfg = config.hyprland;
  dependencies = with pkgs; [
    rofi-wayland # app launcher https://github.com/TheMipMap/NixOS/blob/main/config/home/modules/hyprland/default.nix
    waybar-experimental # Examples: https://github.com/Alexays/Waybar/wiki/Examples
    dunst # or mako | Notification daemon
    libnotify # Required for dunst or mako, sends desktop notifications to a notification daemon

    # Fonts
    font-awesome
    nerdfonts
  ];
in
{
  options = {
    hyprland.enable = lib.mkEnableOption "enable hyprland";
  };

  config = lib.mkIf cfg.enable {

    # https://wiki.hyprland.org/Useful-Utilities/Systemd-start/#uwsm
    wayland.windowManager.hyprland.systemd.enable = false;

    home.sessionVariables = {
      # If your cursor becomes invisible
      # WLR_NO_HARDWARE_CURSORS = "1";

      # Hint electron apps to use wayland
      NIXOS_OZONE_WL = "1";
    };

    # Install dependencies
    home.packages = dependencies;
  };
}

{ pkgs, lib, config, inputs, ... }:
let
  waybar-experimental = pkgs.waybar.overrideAttrs (oldAttrs: {
    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  });

  dependencies = with pkgs; [
    ### These might fit better in the home-manager module
    rofi-wayland # app launcher https://github.com/TheMipMap/NixOS/blob/main/config/home/modules/hyprland/default.nix
    waybar-experimental # Examples: https://github.com/Alexays/Waybar/wiki/Examples
    dunst # or mako | Notification daemon
    libnotify # Required for dunst or mako, sends desktop notifications to a notification daemon
  ]
  # https://wiki.hyprland.org/Nvidia/
  ++ (if (config.nvidia.enable or false) then [
    egl-wayland
    wayland-utils
    kdePackages.wayland-protocols
  ] else [ ]);

in
{
  options = {
    hyprland.enable = lib.mkEnableOption "enable hyprland";
  };

  config = lib.mkIf config.hyprland.enable {

    # https://wiki.nixos.org/wiki/Hyprland
    # https://wiki.hyprland.org/Hypr-Ecosystem/xdg-desktop-portal-hyprland
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      # package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland; # NOTE: This might cause issues!
      portalPackage = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".xdg-desktop-portal-hyprland;
      withUWSM = true;
    };

    environment.sessionVariables = {
      # TODO: Move to home manager module and use home.sessionVariables

      # If your cursor becomes invisible
      # WLR_NO_HARDWARE_CURSORS = "1";

      # Hint electron apps to use wayland
      NIXOS_OZONE_WL = "1";
    };

    # Install dependencies
    environment.systemPackages = dependencies;
  };
}






### Im still unsure if this is needed?
### It seems to work fine without.
# https://mynixos.com/nixpkgs/option/programs.uwsm.waylandCompositors
# programs.uwsm = {
#   enable = true;
#   waylandCompositors = {
#     hyprland = {
#       prettyName = "Hyprland";
#       comment = "Hyprland compositor managed by UWSM";
#       binPath = "/run/current-system/sw/bin/Hyprland";
#     };
#   };
# };

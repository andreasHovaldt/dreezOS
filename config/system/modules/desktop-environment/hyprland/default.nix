{ pkgs, lib, config, inputs, ... }:
let
  dependencies = with pkgs; [ ]
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

{ pkgs, lib, config, inputs, ... }:
let
  dependencies = with pkgs; [
    # System utils
    brightnessctl
  ]
  # https://wiki.hyprland.org/Nvidia/
  ++ (if (config.nvidia.enable or false) then [ egl-wayland ] else [ ]);

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
      # Hint electron apps to use wayland
      NIXOS_OZONE_WL = "1";
    };

    # Install dependencies
    environment.systemPackages = dependencies;
  };
}

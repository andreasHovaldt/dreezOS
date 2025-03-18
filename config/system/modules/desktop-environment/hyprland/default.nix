{ pkgs, lib, config, inputs, ... }:
let
  waybar-experimental = pkgs.waybar.overrideAttrs (oldAttrs: {
    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  });

  dependencies = with pkgs; [
    ### These might fit better in the home-manager module
    kitty # Apparently needed for the default hyprland config?
    # wezterm
    rofi-wayland # app launcher https://github.com/TheMipMap/NixOS/blob/main/config/home/modules/hyprland/default.nix
    #waybar-experimental # Examples: https://github.com/Alexays/Waybar/wiki/Examples
    waybar
    dunst # or mako | Notification daemon
    libnotify # Required for dunst or mako, sends desktop notifications to a notification daemon

    # Wallpaper daemon
    #swww # hyprpaper, swaybg, wpaperd, mpvpaper

    fastfetch

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
      # package = inputs.hyprland.packages."${pkgs.system}".hyprland; # NOTE: This might cause issues!
      #package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
      #portalPackage = inputs.hyprland.packages."${pkgs.system}".xdg-desktop-portal-hyprland;
      portalPackage = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".xdg-desktop-portal-hyprland;
      withUWSM = true;
    };


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

    environment.sessionVariables = {
      # If your cursor becomes invisible
      # WLR_NO_HARDWARE_CURSORS = "1";

      # Hint electron apps to use wayland
      NIXOS_OZONE_WL = "1";
    };

    # Install dependencies
    environment.systemPackages = dependencies;
  };
}

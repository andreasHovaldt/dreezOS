{ pkgs, lib, config, ... }:
let
  # waybar-experimental = pkgs.waybar.overrideAttrs (oldAttrs: {
  #   mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  # });

  cfg = config.hyprland;
  dependencies = with pkgs; [
    hypridle
    rofi-wayland # app launcher https://github.com/TheMipMap/NixOS/blob/main/config/home/modules/hyprland/default.nix

    # Fonts
    font-awesome
    nerdfonts
  ];
in
{
  options = {
    hyprland.enable = lib.mkEnableOption "enable hyprland";
  };

  imports = [
    ./input
    ./keybinds
    ./theme
    ./programs
    ./autostart
  ];

  config = lib.mkIf cfg.enable {

    # Hyprland config
    wayland.windowManager.hyprland = {
      enable = true;

      # https://wiki.hyprland.org/Useful-Utilities/Systemd-start/#uwsm
      systemd.enable = false;

      settings = {

        # See full settings in the files:
        # - ./input/default.nix
        # - ./keybinds/default.nix
        # - ./theme/default.nix
        # - ./programs/default.nix
        # - ./autostart/default.nix

        #############################
        ### ENVIRONMENT VARIABLES ###
        #############################

        # See https://wiki.hyprland.org/Configuring/Environment-variables/

        env = [
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,24"
          #"AQ_DRM_DEVICES,/dev/dri/card1:/dev/dri/card2" # <-- TODO: Check if this is needed, might be an artifact from my old config
        ];

      };

    };

    #wayland.windowManager.hyprland.systemd.enable = false;
    # Install dependencies
    home.packages = dependencies;
  };
}

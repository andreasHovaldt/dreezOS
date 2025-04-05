{ pkgs, lib, config, ... }:
let
  cfg = config.swaync;
  dependencies = with pkgs; [
    swaynotificationcenter # Notification daemon
    libnotify # Sends desktop notifications to notification daemon
  ];
in
{
  options.swaync = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hyprland.enable;
      description = "Enable Sway Notification Center. Defaults to true if Hyprland is enabled.";
    };
  };

  config = lib.mkIf cfg.enable {
    # Swaync config
    # home.file.".config/swaync" = {
    #   source = ./src;
    #   recursive = true;
    # };

    # Enable Sway Notification Center
    services.swaync = {
      enable = true;
      settings = lib.importJSON ./src/config.json;
    };

    # Enable swaync for Hyprland
    wayland.windowManager.hyprland.settings = lib.mkIf config.hyprland.enable {
      exec-once = [ "swaync" ];
    };

    # Install dependencies
    home.packages = dependencies;
  };
}

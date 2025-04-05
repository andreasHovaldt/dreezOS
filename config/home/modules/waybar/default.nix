{ pkgs, lib, config, ... }:
let
  cfg = config.waybar;

  # Waybar experimental version
  waybar-experimental = pkgs.waybar.overrideAttrs (oldAttrs: {
    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  });

in
{
  options.waybar = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hyprland.enable;
      description = "Enable Waybar. Defaults to true if Hyprland is enabled.";
    };

    enableExperimental = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable experimental build of Waybar. Defaults to true.";
    };
  };

  config = lib.mkIf cfg.enable {

    # Waybar config
    home.file.".config/waybar" = {
      source = ./src;
      recursive = true;
    };

    # Enable Waybar for Hyprland
    wayland.windowManager.hyprland.settings = lib.mkIf config.hyprland.enable {
      exec-once = [ "waybar" ];

    };

    # Install dependencies
    home.packages = lib.mkMerge [
      (lib.mkIf cfg.enableExperimental [ waybar-experimental ])
      (lib.mkIf (!cfg.enableExperimental) [ pkgs.waybar ])
    ];
  };
}

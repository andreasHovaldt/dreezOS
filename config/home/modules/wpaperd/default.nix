{ pkgs, lib, config, ... }:
let
  cfg = config.wpaperd;
  dependencies = with pkgs; [ wpaperd hypridle ];
  wallpaperDir = "${config.home.homeDirectory}/.config/wallpapers";

in
{
  options = {
    wpaperd.enable = lib.mkEnableOption "enable wpaperd";
  };

  config = lib.mkIf cfg.enable {


    home.file = {
      # Wallpaper directory
      ".config/wallpapers" = {
        source = ../../../assets/gruvbox-wallpapers/irl;
        recursive = true;
      };
      # Current wallpaper script
      ".config/wpaperd/current-wallpaper.sh" = {
        source = ./current-wallpaper.sh;
        executable = true;
      };
    };

    # wpaperd service config
    # https://mynixos.com/home-manager/options/services.wpaperd
    # https://github.com/danyspin97/wpaperd#wallpaper-configuration
    # Check monitor names with `hyprctl monitors`
    home.file.".config/wpaperd/config.toml" = {
      text = ''
        [default]
        duration = "30m"
        mode = "center"
        sorting = "random"
        recursive = "true"
        path = "${wallpaperDir}"
      '';
      # [eDP-1]
      # duration = "3s"
      # exec = "${config.home.homeDirectory}/.config/wpaperd/current-wallpaper.sh" # TODO: https://github.com/danyspin97/wpaperd/issues/123
    };

    # Add exec-once to hyprland config
    wayland.windowManager.hyprland.settings = lib.mkIf config.hyprland.enable {
      exec-once = [
        "wpaperd"
      ];
    };

    # Install dependencies
    home.packages = dependencies;
  };
}

{ pkgs, lib, config, ... }:
let
  cfg = config.wpaperd;
  dependencies = with pkgs; [ wpaperd ];
  wallpaperDir = "${config.home.homeDirectory}/.config/wallpapers";
  staticWallpaper = "${wallpaperDir}/pexels-stywo-1054218.jpg";

in
{
  options = {
    wpaperd.enable = lib.mkEnableOption "enable wpaperd";
    wpaperd.wallpaperDir = lib.mkOption {
      type = lib.types.path;
      default = wallpaperDir;
      description = "Directory for wallpapers.";
    };
    wpaperd.staticWallpaper = lib.mkOption {
      type = lib.types.path;
      default = staticWallpaper;
      description = "Static wallpaper file.";
    };
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
        mode = "center"
        path = "${cfg.staticWallpaper}"
      '';
      # text = ''
      #   [default]
      #   duration = "30m"
      #   mode = "center"
      #   sorting = "random"
      #   recursive = "true"
      #   path = "${cfg.wallpaperDir}"
      # '';
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

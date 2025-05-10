{ pkgs, unstablePkgs, lib, config, ... }:
let
  cfg = config.wpaperd;
  dependencies = with unstablePkgs; [ wpaperd ];
  wallpaperDir = "${config.home.homeDirectory}/.config/wallpapers";
  staticWallpaper = "${wallpaperDir}/pexels-stywo-1054218.jpg";
  currentWallpaper = "${config.home.homeDirectory}/.config/wpaperd/current-wallpaper";

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
    wpaperd.currentWallpaper = lib.mkOption {
      type = lib.types.path;
      default = currentWallpaper;
      description = "Dynamic wallpaper file.";
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
        # source = ./current-wallpaper.sh;
        text = ''#!${pkgs.bash}/bin/bash
        '' + builtins.readFile(./current-wallpaper.sh);
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
        path = "${cfg.wallpaperDir}"
      
        [eDP-1]
        exec = "${currentWallpaper}.sh"
      '';
    };

    # Add exec-once to hyprland config
    wayland.windowManager.hyprland.settings = lib.mkIf config.hyprland.enable {
      # exec-once = [ "wpaperd" ];
      exec-once = [ "bash -c 'sleep 2 && wpaperd'" ]; # Sleep to ensure it is run after stylix
    };

    # Install dependencies
    home.packages = dependencies;
  };
}

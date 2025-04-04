{ pkgs, lib, config, ... }:
let
  cfg = config.wpaperd;
  dependencies = with pkgs; [ wpaperd ];

  wallpaper_dir = "${config.home.homeDirectory}/.config/wallpapers";

in
{
  options = {
    wpaperd.enable = lib.mkEnableOption "enable wpaperd";
  };

  config = lib.mkIf cfg.enable {

    # Wallpaper directory
    home.file = {
      ".config/wallpapers" = {
        source = ../../../assets/gruvbox-wallpapers/irl;
        recursive = true;
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
        path = "${wallpaper_dir}"
      '';
    };

    # Add exec-once to hyprland config
    # wayland.windowManager.hyprland.settings = lib.mkIf cfg.hyprland.enable {
    #   exec-once = [
    #     "wpaperd &"
    #   ];
    # };

    # Install dependencies
    home.packages = dependencies;
  };
}

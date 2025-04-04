{ pkgs, lib, config, ... }:
let
  cfg = config.hyprpaper;
  dependencies = with pkgs; [ ];

  wallpaper_dir = "${config.home.homeDirectory}/.config/wallpapers";
  wallpaper_1 = "${wallpaper_dir}/road.jpg"; # Default wallpaper

in
{
  options = {
    hyprpaper.enable = lib.mkEnableOption "enable hyprpaper";
  };

  config = lib.mkIf cfg.enable {

    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [ wallpaper_1 ];
        wallpaper = [
          #"monitor1,${wallpaper_1}"
          ",${wallpaper_1}"
        ];
      };
    };

    # Hyprpaper
    home.file = {
      ".config/wallpapers" = {
        source = ../../../assets/gruvbox-wallpapers/irl;
        recursive = true;
      };
    };

    # Enable the service
    # TODO: Enable once hyprland config is managed by nix
    # wayland.windowManager.hyprland.settings = {
    #   exec-once = [
    #     "systemctl --user enable --now hyprpaper.service"
    #   ];
    # };

    # Install dependencies
    home.packages = dependencies;
  };
}

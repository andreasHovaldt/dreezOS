{ pkgs, lib, config, ... }:
let
  cfg = config.stylix-theme;
  dependencies = with pkgs; [ ];
in
{
  options.stylix-theme = {
    enable = lib.mkEnableOption "enable stylix-theme";

    wallpaper = lib.mkOption {
      type = lib.types.str;
      default = "gruvbox-wallpapers/irl/road.jpg";
    };

  };

  config = lib.mkIf cfg.enable {

    home.file.".config/stylix" = {
      "wallpaper" = {
        source = "../../../assets/${cfg.wallpaper}";
      };
    };

    # Install dependencies
    home.packages = dependencies;
  };
}

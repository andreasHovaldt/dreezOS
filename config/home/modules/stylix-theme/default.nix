{ pkgs, lib, config, ... }:
let
  cfg = config.stylix-theme;
  dependencies = with pkgs; [ ];
in
{
  options.stylix-theme = {
    enable = lib.mkEnableOption "enable stylix-theme";

    colorscheme = lib.mkOption {
      type = lib.types.str;
      default = "da-one-black"; # da-one-black, ayu-dark, ayu-mirage
      description = ''
        The color scheme to use. See the Tinted Gallery for more options.
        https://tinted-theming.github.io/tinted-gallery/
      '';
    };

    wallpaper = lib.mkOption {
      type = lib.types.path;
      default = ./../../../assets/gruvbox-wallpapers/irl/road.jpg;
      description = "Path to the wallpaper image.";
    };

  };

  config = lib.mkIf cfg.enable {

    stylix = {
      enable = true;
      autoEnable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${cfg.colorscheme}.yaml";
      image = cfg.wallpaper;
    };

    # Install dependencies
    home.packages = dependencies;
  };
}

{ pkgs, lib, config, ... }:
let
  cfg = config.stylix-theme;
  dependencies = with pkgs; [
    ## -- Write pkgs dependencies here -- ##



    ## -- End of dependencies -- ##
  ];
in
{
  options.stylix-theme = {
    enable = lib.mkEnableOption "enable stylix-theme";

    colorscheme = lib.mkOption {
      type = lib.types.str;
      default = "ayu-dark"; # ayu-dark, ayu-mirage
      description = ''
        The color scheme to use. See the Tinted Gallery for more options.
        https://tinted-theming.github.io/tinted-gallery/
      '';
    };

    wallpaper = lib.mkOption {
      type = lib.types.str;
      default = "gruvbox-wallpapers/irl/road.jpg";
    };

  };

  config = lib.mkIf cfg.enable {
    ## -- Write your configuration here -- ##

    home.file.".config/stylix" = {
      "wallpaper" = {
        source = "../../../assets/${cfg.wallpaper}";
      };
    };

    fonts.fontconfig.enable = true;




    ## -- End of configuration -- ##

    # Install dependencies
    home.packages = dependencies;
  };
}

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
      default = "../../../assets/gruvbox-wallpapers/irl/road.jpg";
    };

  };

  config = lib.mkIf cfg.enable {
    ## -- Write your configuration here -- ##

    stylix = {
      enable = true;
      autoEnable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${cfg.colorscheme}.yaml";
      #image = cfg.wallpaper;
      image = ../../../assets/gruvbox-wallpapers/irl/road.jpg;
    };

    ## -- End of configuration -- ##

    # Install dependencies
    environment.systemPackages = dependencies;
  };
}

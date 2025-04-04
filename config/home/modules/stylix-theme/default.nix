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

  };

  config = lib.mkIf cfg.enable {

    stylix = {
      enable = true;
      autoEnable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${cfg.colorscheme}.yaml";
    };

    # Install dependencies
    home.packages = dependencies;
  };
}

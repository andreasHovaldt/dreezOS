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
      default = ../../../assets/gruvbox-wallpapers/irl/village.jpg;
      description = "Path to the wallpaper image.";
    };

  };

  config = lib.mkIf cfg.enable {

    stylix = {
      enable = true;
      autoEnable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${cfg.colorscheme}.yaml";
      image = cfg.wallpaper;
      homeManagerIntegration = {
        autoImport = true;
        followSystem = true;
      };

      fonts = {
        serif = {
          # package = pkgs.dejavu_fonts;
          # name = "DejaVu Serif";
          package = pkgs.nerdfonts;
          name = "CodeNewRoman Nerd Font Propo";
        };

        sansSerif = {
          # package = pkgs.dejavu_fonts;
          # name = "DejaVu Sans";
          package = pkgs.nerdfonts;
          name = "CodeNewRoman Nerd Font Propo";
        };

        monospace = {
          # package = pkgs.dejavu_fonts;
          # name = "DejaVu Sans Mono";
          # package = pkgs.nerdfonts;
          # name = "CodeNewRoman Nerd Font Mono";
          package = pkgs.jetbrains-mono;
          name = "JetBrains Mono";
        };

        emoji = {
          # package = pkgs.noto-fonts-emoji;
          # name = "Noto Color Emoji";
          package = pkgs.twitter-color-emoji;
          name = "Twemoji";
        };

        sizes = {
          applications = 12;
          desktop = 12;
          popups = 12;
          terminal = 12;
        };
      };


    };



    # Install dependencies
    environment.systemPackages = dependencies;
  };
}

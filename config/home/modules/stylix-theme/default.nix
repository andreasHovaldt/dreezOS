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

      # Enable custom icon theming in GTK apps
      iconTheme = {
        enable = true;
        package = pkgs.papirus-icon-theme;
        light = "Papirus";
        dark = "Papirus-Dark";
      };
    };

    # Enable Stylix fonts for Home-manager
    fonts.fontconfig.enable = true;


    # Create file showing current Stylix variables
    home.file = {
      ".config/stylix/current-config.txt" = {
        text = ''
          Stylix variables
          ==================
          
          Base16 scheme: "${config.stylix.base16Scheme}"
          
          Fonts: 
          - Serif: "${config.stylix.fonts.serif.name}"
          - SansSerif: "${config.stylix.fonts.sansSerif.name}"
          - Monospace: "${config.stylix.fonts.monospace.name}"
          - Emoji: "${config.stylix.fonts.emoji.name}"
          
          Font sizes:
          - Applications: "${toString config.stylix.fonts.sizes.applications}"
          - Desktop: "${toString config.stylix.fonts.sizes.desktop}"
          - Popups: "${toString config.stylix.fonts.sizes.popups}"
          - terminal: "${toString config.stylix.fonts.sizes.terminal}"
        '';
      };
    };


    # Install dependencies
    home.packages = dependencies;
  };
}

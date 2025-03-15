{ pkgs, lib, config, ... }:
let
  cfg = config.ghostty;
  dependencies = with pkgs; [
    ghostty
  ];
in
{
  options = {
    ghostty.enable = lib.mkEnableOption "enable ghostty";
  };

  config = lib.mkIf cfg.enable {

    programs.ghostty = {
      enable = true;

      settings = {
        clipboard-read = "allow";
        clipboard-write = "allow";
        copy-on-select = true;
        background-opacity = 0.85;
        background-blur = 20;
        mouse-hide-while-typing = true;

        window-theme = "dark";
        theme = "tokyonight";
        #theme = "midnight-in-mojave";
        #theme = "iTerm Smoooooth";
        minimum-contrast = 2;
        background = "#1a1b26";
        foreground = "#c0caf5";
        selection-background = "#33467c";
        selection-foreground = "#c0caf5";
        cursor-color = "#c0caf5";
        cursor-text = "#15161e";
        cursor-style = "bar";
        palette = [
          "0=#15161e"
          "1=#f7768e"
          "2=#9ece6a"
          "3=#e0af68"
          "4=#7aa2f7"
          "5=#bb9af7"
          "6=#7dcfff"
          "7=#a9b1d6"
          "8=#414868"
          "9=#f7768e"
          "10=#9ece6a"
          "11=#e0af68"
          "12=#7aa2f7"
          "13=#bb9af7"
          "14=#7dcfff"
          "15=#c0caf5"
          "16=#3ddbd9"
        ];
      };
    };

    # Install dependencies
    home.packages = dependencies;
  };
}

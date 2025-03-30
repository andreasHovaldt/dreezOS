{ pkgs, lib, config, ... }:
let
  cfg = config.terminal;
  dependencies = with pkgs; [ ];
in
{
  options.terminal = {
    enable = lib.mkEnableOption "enable terminal config";

    wezterm.enable = lib.mkOption {
      type = lib.types.bool;
      default = cfg.enable;
    };

    ghostty.enable = lib.mkEnableOption "enable ghostty";
    kitty.enable = lib.mkEnableOption "enable kitty";
    alacritty.enable = lib.mkEnableOption "enable alacritty";
  };

  config = lib.mkIf cfg.enable {
    # Wezterm setup
    programs.wezterm = lib.mkIf cfg.wezterm.enable {
      enable = true;
      enableBashIntegration = lib.mkIf config.shell.bash.enable true;
      enableZshIntegration = lib.mkIf config.shell.zsh.enable true;
    };

    # Ghostty setup
    programs.ghostty = lib.mkIf cfg.ghostty.enable {
      enable = true;
      enableBashIntegration = lib.mkIf config.shell.bash.enable true;
      enableZshIntegration = lib.mkIf config.shell.zsh.enable true;
      settings = {
        clipboard-read = "allow";
        clipboard-write = "allow";
        #mouse-hide-while-typing = true;
        gtk-single-instance = true; # morty hack for speedup
      };
    };

    ### TODO: make the other configs

    # Install dependencies
    home.packages = dependencies;
  };
}

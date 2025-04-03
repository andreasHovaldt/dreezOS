{ pkgs, lib, config, ... }:
let
  cfg = config.terminal;
  dependencies = with pkgs; [ ] ++
    lib.optionals cfg.wezterm.enable [ wezterm ] ++
    lib.optionals cfg.ghostty.enable [ ghostty ] ++
    lib.optionals cfg.kitty.enable [ kitty ] ++
    lib.optionals cfg.alacritty.enable [ alacritty ];
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
    # Kitty setup
    programs.kitty = lib.mkIf cfg.kitty.enable {
      enable = true;
      shellIntegration = {
        enableBashIntegration = lib.mkIf config.shell.bash.enable true;
        enableZshIntegration = lib.mkIf config.shell.zsh.enable true;
      };
      settings = { };
    };

    programs.alacritty = lib.mkIf cfg.alacritty.enable {
      enable = true;
      settings = { };
    };


    # Install dependencies
    home.packages = dependencies;
  };
}

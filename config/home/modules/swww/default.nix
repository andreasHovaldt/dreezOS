# Wallpaper manager

{ pkgs, lib, config, ... }:
let
  cfg = config.swww;
  dependencies = with pkgs; [ swww ];

  # Define paths within user home directory # NOTE: Do not touch
  wallpaperScript = "${config.home.homeDirectory}/.config/swww/wp-switcher.sh";
  wallpaperDir = "${config.home.homeDirectory}/.config/swww/wallpapers";
in
{
  options = {
    swww.enable = lib.mkEnableOption "enable swww";
  };

  config = lib.mkIf cfg.enable {

    home.sessionVariables = {
      SWWW_DEFAULT_INTERVAL = "1800";
      SWWW_TRANSITION_FPS = "90";
      SWWW_TRANSITION_STEP = "5";
    };

    # Ensure the wallpaper switcher script is placed in ~/.config
    home.file.".config/swww/wp-switcher.sh" = {
      source = ./wp-switcher.sh;
      executable = true;
    };

    # Ensure the wallpaper directory is available (optional: symlink)
    home.file.".config/swww/wallpapers" = {
      source = ../../../assets/gruvbox-wallpapers/irl;
      recursive = true;
    };

    # Start user-based systemd service
    systemd.user.services.wallpaper-switcher = {
      Unit = {
        Description = "Random Wallpaper Setter";
        After = [ "graphical-session.target" ]; # Starts when graphical session starts
        PartOf = [ "graphical-session.target" ]; # Only runs while graphical session runs
      };
      Service = {
        ExecStart = "${pkgs.runtimeShell} -c '${wallpaperScript} ${wallpaperDir}'"; # Runs the wp-switcher script
        Restart = "always";
        ExecStartPre = "-${pkgs.swww}/bin/swww-daemon"; # Ensures swww is initialized
      };
      Install = {
        WantedBy = [ "default.target" ]; # Ensures the service starts automatically when you log in
      };
    };

    # Install dependencies
    home.packages = dependencies;
  };
}

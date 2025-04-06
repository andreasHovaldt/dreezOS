{ pkgs, lib, config, ... }:
let
  cfg = config.hyprlock;
  currentWallpaper = "${config.home.homeDirectory}/.config/wpaperd/current_wallpaper";
  dependencies = with pkgs; [ ];
in
{
  options.hyprlock = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hyprland.enable;
      description = "Enable hyprlock. Defaults to true if Hyprland is enabled.";
    };
  };

  config = lib.mkIf cfg.enable {

    # Disable Stylix setting the lock screen wallpaper
    #stylix.targets.hyprlock.useWallpaper = false;


    # current wallpaper $(wpaperctl get-wallpaper eDP-1)
    programs.hyprlock = {
      enable = true;

      settings = with config.lib.stylix.colors; {
        general = {
          disable_loading_bar = true;
          grace = 300;
          hide_cursor = true;
          no_fade_in = false;
        };

        background = lib.mkForce [{
          #path = "$(wpaperctl get-wallpaper eDP-1)";
          #path = currentWallpaper; # TODO: https://github.com/danyspin97/wpaperd/issues/123
          path = "/home/dreezy/.config/wallpapers/pexels-stywo-1054218.jpg";
          blur_size = 5;
          blur_passes = 3;
          brightness = 0.6;
          # reload_time = 1;
          # reload_cmd = "wpaperctl get-wallpaper eDP-1"; # https://wiki.hyprland.org/Hypr-Ecosystem/hyprlock/#background
        }];

        input-field = with config.lib.stylix.colors.withHashtag; lib.mkForce [{
          monitor = "";
          size = "6%, 4%";
          outline_thickness = 0;
          dots_rounding = 4;
          dots_spacing = 0.5;
          # dots_fase_time = 300;
          # inner_color = "${base00}";
          # outer_color = "${base00} ${base00}";
          # check_color = "${base00} ${base00}";
          # fail_color = "${base00} ${base00}";
          # font_color = "${base09}";
          # inner_color = "rgb(0,0,0)";
          # outer_color = "$rgb(0,0,0) rgb(0,0,0)";
          # check_color = "$rgb(0,0,0) rgb(0,0,0)";
          # fail_color = "$rgb(0,0,0) rgb(0,0,0)";
          # font_color = "rgb(255,195,135)";
          font_family = "CodeNewRoman Nerd Font Propo";
          fade_on_empty = false;
          shadow_color = "rgba(0,0,0,0.5)";
          shadow_passes = 2;
          shadow_size = 2;
          rounding = 20;
          placeholder_text = "<i></i>";
          fail_text = "<b>FAIL</b>";
          fail_timeout = 300;
          position = "0, -100";
          halign = "center";
          valign = "center";
        }];

        label = with config.lib.stylix.colors.withHashtag; [
          {
            monitor = "";
            text = ''cmd[update:1000] date +"<b>%I</b>"'';
            # color = "${base09}";
            # color = "rgba(255,195,135,1.0)";
            font_size = 200;
            font_family = "CodeNewRoman Nerd Font Propo";
            shadow_passes = 0;
            shadow_size = 5;
            position = "-120, 410";
            halign = "center";
            valign = "center";
          }
          {
            monitor = "";
            text = ''cmd[update:1000] date +"<b>%M</b>"'';
            color = "rgba(150,150,150, .4)";
            font_size = 200;
            font_family = "CodeNewRoman Nerd Font Propo";
            shadow_passes = 0;
            shadow_size = 5;
            position = "120, 230";
            halign = "center";
            valign = "center";
          }
          {
            monitor = "";
            text = ''cmd[update:1000] date +"<b>%A, %B %d, %Y</b>"'';
            # color = "${base04}";
            font_size = 40;
            font_family = "CodeNewRoman Nerd Font Propo";
            shadow_passes = 0;
            shadow_size = 4;
            # position = "-40, -20";
            halign = "right";
            # valign = "top";
            position = "-40, 20";
            # halign = "center";
            valign = "bottom";
          }
          {
            monitor = "";
            text = ''<i>Hello</i> <b>$USER</b>'';
            # color = "rgba(255,255,255,1.0)";
            font_size = 40;
            font_family = "CodeNewRoman Nerd Font Propo";
            shadow_passes = 0;
            shadow_size = 4;
            position = "40, -20";
            halign = "left";
            valign = "top";
            # position = "0,400";
            # halign = "center";
            # valign = "center";
          }
        ];

      };

    };

    # Set lock bind for Hyprland
    wayland.windowManager.hyprland.settings = lib.mkIf config.hyprland.enable {
      bindd = [
        "$mainMod, L, Lock Screen, exec, hyprlock"
        ", XF86LogOff, Lock Screen, exec, hyprlock"
      ];
    };

    # Install dependencies
    home.packages = dependencies;
  };
}

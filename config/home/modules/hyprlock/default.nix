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
          disable_loading_bar = false;
          grace = 0;
          hide_cursor = true;
          no_fade_in = false;
        };

        background = lib.mkForce {
          #path = "$(wpaperctl get-wallpaper eDP-1)";
          #path = currentWallpaper; # TODO: https://github.com/danyspin97/wpaperd/issues/123
          path = "/home/dreezy/.config/wallpapers/pexels-stywo-1054218.jpg";
          blur_size = 5;
          blur_passes = 3;
          brightness = 0.6;
          # reload_time = 1;
          # reload_cmd = "wpaperctl get-wallpaper eDP-1"; # https://wiki.hyprland.org/Hypr-Ecosystem/hyprlock/#background
        };

        input-field = lib.mkMerge [{
          monitor = "";
          size = "400, 80";
          outline_thickness = 0;
          dots_rounding = -1;
          dots_spacing = 0.5;
          font_family = "CodeNewRoman Nerd Font Propo";
          fade_on_empty = false;
          shadow_color = "rgba(0,0,0,0.5)";
          shadow_passes = 2;
          shadow_size = 2;
          rounding = 20;
          placeholder_text = "<b><i></i></b>";
          fail_text = "<b><i>  </i></b>";
          fail_timeout = 1000;
          position = "0, -220";
          halign = "center";
          valign = "center";
        }];

        label = [
          {
            monitor = "";
            text = ''cmd[update:1000] date +"<b>%I</b>"'';
            color = "rgba(255,255,255,1.0)";
            font_size = 200;
            font_family = "CodeNewRoman Nerd Font Propo";
            shadow_passes = 0;
            shadow_size = 5;
            position = "-120, 310";
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
            position = "120, 130";
            halign = "center";
            valign = "center";
          }
          {
            monitor = "";
            text = ''cmd[update:1000] date +"<b>%A, %B %d, %Y</b>"'';
            color = "rgba(255,255,255,0.7)";
            font_size = 40;
            font_family = "CodeNewRoman Nerd Font Propo";
            shadow_passes = 0;
            shadow_size = 4;
            position = "-40, 20";
            halign = "right";
            valign = "bottom";
          }
          {
            monitor = "";
            text = ''<i>Hello</i> <b>$USER</b>'';
            color = "rgba(255,255,255,0.7)";
            font_size = 40;
            font_family = "CodeNewRoman Nerd Font Propo";
            shadow_passes = 0;
            shadow_size = 4;
            position = "40, -20";
            halign = "left";
            valign = "top";
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

      # https://wiki.hyprland.org/Configuring/Binds/#switches
      bindld = [
        ", switch:Lid Switch, Lock Screen when closing lid switch, exec, hyprlock"
        #", switch:on:Lid Switch, Lock Screen when closing lid switch, exec, hyprlock"
      ];
    };

    # Install dependencies
    home.packages = dependencies;
  };
}

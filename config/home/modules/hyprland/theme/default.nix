{ lib, ... }:
{
  wayland.windowManager.hyprland.settings = {
    #####################
    ### LOOK AND FEEL ###
    #####################

    # Refer to https://wiki.hyprland.org/Configuring/Variables/

    # https://wiki.hyprland.org/Configuring/Variables/#general
    general = {
      "gaps_in" = "5";
      "gaps_out" = "10";

      "border_size" = "2";

      # Set to true enable resizing windows by clicking and dragging on borders and gaps
      "resize_on_border" = "true";
      "extend_border_grab_area" = "true";
      "hover_icon_on_border" = "true";

      # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
      "allow_tearing" = "false";

      "layout" = "dwindle";
    };

    # https://wiki.hyprland.org/Configuring/Variables/#decoration
    decoration = {
      "rounding" = "10";
      #rounding_power = 2

      # Change transparency of focused and unfocused windows
      "active_opacity" = "1.0";
      "inactive_opacity" = "0.8";

      shadow = {
        "enabled" = "true";
        "range" = "4";
        "render_power" = "3";
      };

      # https://wiki.hyprland.org/Configuring/Variables/#blur
      blur = {
        "enabled" = "true";
        "size" = "3";
        "passes" = "1";

        "vibrancy" = "0.1696";
      };
    };

    # https://wiki.hyprland.org/Configuring/Variables/#animations
    animations = {
      enabled = "yes, please :)";

      # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

      bezier = [
        "easeOutQuint, 0.23, 1, 0.32, 1"
        "easeInOutCubic, 0.65, 0.05, 0.36, 1"
        "linear, 0, 0, 1, 1"
        "almostLinear, 0.5, 0.5, 0.75, 1.0"
        "quick, 0.15, 0, 0.1, 1"
      ];

      animation = [
        "global, 1, 10, default"
        "border, 1, 5.39, easeOutQuint"
        "windows, 1, 4.79, easeOutQuint"
        "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
        "windowsOut, 1, 1.49, linear, popin 87%"
        "fadeIn, 1, 1.73, almostLinear"
        "fadeOut, 1, 1.46, almostLinear"
        "fade, 1, 3.03, quick"
        "layers, 1, 3.81, easeOutQuint"
        "layersIn, 1, 4, easeOutQuint, fade"
        "layersOut, 1, 1.5, linear, fade"
        "fadeLayersIn, 1, 1.79, almostLinear"
        "fadeLayersOut, 1, 1.39, almostLinear"
        "workspaces, 1, 1.94, almostLinear, fade"
        "workspacesIn, 1, 1.21, almostLinear, fade"
        "workspacesOut, 1, 1.94, almostLinear, fade"
      ];
    };

    # Ref https://wiki.hyprland.org/Configuring/Workspace-Rules/
    # "Smart gaps" / "No gaps when only"
    # uncomment all if you wish to use that.
    # workspace = w[tv1], gapsout:0, gapsin:0
    # workspace = f[1], gapsout:0, gapsin:0
    # windowrulev2 = bordersize 0, floating:0, onworkspace:w[tv1]
    # windowrulev2 = rounding 0, floating:0, onworkspace:w[tv1]
    # windowrulev2 = bordersize 0, floating:0, onworkspace:f[1]
    # windowrulev2 = rounding 0, floating:0, onworkspace:f[1]

    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
    dwindle = {
      "pseudotile" = "true"; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
      "preserve_split" = "true"; # You probably want this
    };

    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
    master = {
      "new_status" = "master";
    };

    # https://wiki.hyprland.org/Configuring/Variables/#misc
    misc = {
      "force_default_wallpaper" = "0"; # Set to 0 or 1 to disable the anime mascot wallpapers
      "disable_hyprland_logo" = "true"; # If true disables the random hyprland logo / anime girl background. :(
    };



    ##############################
    ### WINDOWS AND WORKSPACES ###
    ##############################

    # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
    # See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules

    # Example windowrule v1
    # windowrule = float, ^(kitty)$

    # Example windowrule v2
    # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$

    windowrulev2 = [
      "suppressevent maximize, class:.*" # Ignore maximize requests from apps. You'll probably like this.
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0" # Fix some dragging issues with XWayland
    ];

  };
}

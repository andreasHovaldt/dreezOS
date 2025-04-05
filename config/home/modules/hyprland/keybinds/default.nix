{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    ###################
    ### KEYBINDINGS ###
    ###################

    # See https://wiki.hyprland.org/Configuring/Keywords/
    # Flags https://wiki.hyprland.org/Configuring/Binds/#bind-flags --> bind[flag] = []
    "$mainMod" = "SUPER"; # Sets "Windows" key as main modifier

    # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more

    # d -> has description, will allow you to write a description for your bind.
    bindd = [
      "$mainMod, T, Start Terminal, exec, $terminal"
      "$mainMod, K, Kill Active Window, killactive,"
      "$mainMod, M, Logout Of Hyprland, exit,"
      "$mainMod, E, Start File Manager, exec, $fileManager"
      "$mainMod, V, Toggle Floating for Focused Window, togglefloating,"
      "$mainMod, F, Toggle Fullscreen, fullscreen,"
      "$mainMod, Space, Run Menu, exec, $menuClose || $menu" # Should probably choose
      "$mainMod, R, Run Menu, exec, $menuClose || $menu" # between one of these
      "$mainMod, P, , pseudo," # dwindle
      "$mainMod, J, , togglesplit," # dwindle
    ];


    bind = [
      # Move focus with mainMod + arrow keys
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"

      # Move Windows With Arrows
      "$mainMod SHIFT, left, movewindow, l"
      "$mainMod SHIFT, right, movewindow, r"
      "$mainMod SHIFT, up, movewindow, u"
      "$mainMod SHIFT, down, movewindow, d"

      # Resize Windows With Arrows
      "$mainMod CTRL, left, resizeactive, -30 0"
      "$mainMod CTRL, right, resizeactive, 30 0"
      "$mainMod CTRL, up, resizeactive, 0 -30"
      "$mainMod CTRL, down, resizeactive, 0 30"

      # Switch workspaces with mainMod + [0-9]
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"

      # Example special workspace (scratchpad)
      "$mainMod, S, togglespecialworkspace, magic"
      "$mainMod SHIFT, S, movetoworkspace, special:magic"

      # Scroll through existing workspaces with mainMod + scroll
      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"
    ];

    # m -> mouse
    bindm = [
      # Move/resize windows with mainMod + LMB/RMB and dragging
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    # e -> repeat, will repeat when held.
    # l -> locked, will also work when an input inhibitor (e.g. a lockscreen) is active.
    bindel = [
      # Laptop multimedia keys for volume and LCD brightness
      ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ", XF86MonBrightnessUp, exec, brightnessctl s 5%+"
      ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
    ];

    # Requires playerctl - Note: I dont have this on Yoga, but might be useful on other configs, remember to add the package
    bindl = [
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];
  };
}

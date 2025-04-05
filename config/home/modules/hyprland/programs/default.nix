{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    ###################
    ### MY PROGRAMS ###
    ###################

    # See https://wiki.hyprland.org/Configuring/Keywords/

    # Set programs that you use
    "$terminal" = "wezterm";
    "$fileManager" = "thunar";
    "$menu" = "rofi -show drun -show-icons";
    "$menuClose" = "pkill rofi";
  };
}

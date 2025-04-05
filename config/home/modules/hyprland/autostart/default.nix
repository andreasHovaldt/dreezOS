{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    #################
    ### AUTOSTART ###
    #################

    # Autostart necessary processes (like notifications daemons, status bars, etc.)
    # Or execute your favorite apps at launch like this:

    exec-once = [
      "nm-applet - -indicator"
    ];

  };
}

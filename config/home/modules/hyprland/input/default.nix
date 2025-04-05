{ ... }:
{
  wayland.windowManager.hyprland.settings = {


    #############
    ### INPUT ###
    #############

    # https://wiki.hyprland.org/Configuring/Variables/#input
    input = {
      "kb_layout" = "dk";
      "kb_variant" = "";
      "kb_model" = "";
      "kb_options" = "";
      "kb_rules" = "";

      "follow_mouse" = "1";

      "sensitivity" = "0"; # -1.0 - 1.0, 0 means no modification.

      touchpad = {
        "natural_scroll" = "true";
      };
    };

    # https://wiki.hyprland.org/Configuring/Variables/#gestures
    gestures = {
      "workspace_swipe" = "true";
    };
  };
}

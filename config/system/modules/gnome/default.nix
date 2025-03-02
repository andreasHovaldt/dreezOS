{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [ ];
in
{
  options = {
    gnome.enable = lib.mkEnableOption "enable gnome";
  };

  config = lib.mkIf config.gnome.enable {

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the GNOME Desktop Environment.
    # https://www.reddit.com/r/linux4noobs/comments/vluh1i/what_are_the_difference_among_display_manager/
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    # Install dependencies
    environment.systemPackages = dependencies;
  };
}

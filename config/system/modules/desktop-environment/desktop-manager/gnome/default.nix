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

    # Enable the gnome desktop manager.
    services.xserver.desktopManager.gnome.enable = true;

    # Install dependencies
    environment.systemPackages = dependencies;
  };
}

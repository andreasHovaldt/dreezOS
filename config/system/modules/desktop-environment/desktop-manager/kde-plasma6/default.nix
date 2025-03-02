{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [ ];
in
{
  options = {
    kde-plasma6.enable = lib.mkEnableOption "enable kde-plasma6";
  };

  config = lib.mkIf config.kde-plasma6.enable {

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the KDE Plasma 6 desktop manager.
    services.desktopManager.plasma6.enable = true;

    # Install dependencies
    environment.systemPackages = dependencies;
  };
}

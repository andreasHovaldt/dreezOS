{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [ ];
in
{
  options = {
    gdm.enable = lib.mkEnableOption "enable gdm";
  };

  config = lib.mkIf config.gdm.enable {

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the gdm display manager.
    services.xserver.displayManager.gdm.enable = true;

    # Install dependencies
    environment.systemPackages = dependencies;
  };
}

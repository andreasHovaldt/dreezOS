{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    ## -- Write pkgs dependencies here -- ##



    ## -- End of dependencies -- ##
  ];
in
{
  options = {
    sddm.enable = lib.mkEnableOption "enable sample-module";
  };

  config = lib.mkIf config.sddm.enable {

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the sddm display manager.
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;
    services.displayManager.sddm.settings.General.DisplayServer = "wayland";

    # Install dependencies
    environment.systemPackages = dependencies;
  };
}

{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    ## -- Write pkgs dependencies here -- ##



    ## -- End of dependencies -- ##
  ];
in
{
  options = {
    bluetooth.enable = lib.mkEnableOption "enable bluetooth";
  };

  config = lib.mkIf config.bluetooth.enable {

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true; # Whether to power up the default Bluetooth controller on boot.
    };

    # Install dependencies
    environment.systemPackages = dependencies;
  };
}

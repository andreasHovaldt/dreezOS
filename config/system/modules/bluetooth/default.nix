{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    bluez
  ];
in
{
  options = {
    bluetooth.enable = lib.mkEnableOption "enable bluetooth";
  };

  config = lib.mkIf config.bluetooth.enable {
    # https://nixos.wiki/wiki/Bluetooth

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false; # Whether to power up the default Bluetooth controller on boot.
      settings = {
        General = {
          Experimental = true; # Useful for displaying bluetooth device charge.
        };
      };
    };

    services.blueman.enable = true; # Used for pairing bluetooth devices to the machine.

    # Install dependencies
    environment.systemPackages = dependencies;
  };
}

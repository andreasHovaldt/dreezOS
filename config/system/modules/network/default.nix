{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    pkgs.networkmanagerapplet

    # VPN pkgs
    openconnect
    wireguard-tools
  ];
in
{
  options = {
    network.enable = lib.mkEnableOption "enable network";
  };

  config = lib.mkIf config.network.enable {

    # Enable networking
    networking.networkmanager.enable = true;

    # Install dependencies
    environment.systemPackages = dependencies;
  };
}

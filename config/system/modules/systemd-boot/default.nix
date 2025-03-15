{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [ ];
in
{
  options = {
    systemd-boot.enable = lib.mkEnableOption "enable systemd-boot";
  };

  config = lib.mkIf config.systemd-boot.enable {

    boot.loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };

    # Install dependencies
    environment.systemPackages = dependencies;
  };
}

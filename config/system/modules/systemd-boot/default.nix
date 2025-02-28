{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    ## -- Write pkgs dependencies here -- ##



    ## -- End of dependencies -- ##
  ];
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

{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [ ];
in
{
  options = {
    power.enable = lib.mkEnableOption "enable power";
  };

  config = lib.mkIf config.power.enable {

    services.upower = {
      enable = true;
      percentageLow = 30;
      percentageCritical = 10;
      percentageAction = 3;
      criticalPowerAction = "Hibernate";
    };

    # Enable performance mode
    # powerManagement = {
    #   enable = true;
    #   cpuFreqGovernor = "performance";
    # };


    # Install dependencies
    environment.systemPackages = dependencies;
  };
}

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
      percentageAction = 5;
      criticalPowerAction = "Hibernate";
    };

    # Whether to enable power-profiles-daemon, a DBus daemon that allows 
    # changing system behavior based upon user-selected power profiles.
    # services.power-profiles-daemon.enable = true;

    services.tlp = {
      enable = true;
      settings = {
        # Selects the CPU scaling governor for automatic frequency scaling.
        # Choices: performance, powersave
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        # Set CPU energy/performance policies
        # Choices: performance, balance_performance, default, balance_power, power
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        # Configure CPU turbo
        # Choices: 0 - disable, 1 - enable
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        # Set battery charge thesholds
        START_CHARGE_THRESH_BAT0 = 0; # dummy value
        STOP_CHARGE_THRESH_BAT0 = 1;

      };
    };

    # Enable performance mode
    # powerManagement = {
    #   enable = true;
    #   cpuFreqGovernor = "performance"; # "ondemand", "powersave", "performance"
    # };




    # Install dependencies
    environment.systemPackages = dependencies;
  };
}

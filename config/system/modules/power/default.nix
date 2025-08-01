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
      criticalPowerAction = "PowerOff"; # "PowerOff", "Hibernate", "HybridSleep", "Suspend", "Ignore"
    };

    # Whether to enable power-profiles-daemon, a DBus daemon that allows 
    # changing system behavior based upon user-selected power profiles.
    # services.power-profiles-daemon.enable = true;

    services.tlp = {
      enable = true;
      settings = {
        
        # Select the platform profile to control system operating characteristics areound power/performance levels
        # https://linrunner.de/tlp/settings/platform.html#platform-profile-on-ac-bat
        # Choices: performance, balanced, low-power
        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "low-power";
        
        # Selects the CPU scaling governor for automatic frequency scaling.
        # https://linrunner.de/tlp/settings/processor.html#cpu-scaling-governor-on-ac-bat
        # Choices: performance, powersave
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        # Set CPU energy/performance policies
        # https://linrunner.de/tlp/settings/processor.html#cpu-energy-perf-policy-on-ac-bat
        # Choices: performance, balance_performance, default, balance_power, power
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        # Configure CPU turbo
        # https://linrunner.de/tlp/settings/processor.html#cpu-boost-on-ac-bat
        # Choices: 0 - disable, 1 - enable
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        # Set battery charge thesholds
        # https://linrunner.de/tlp/settings/battery.html#start-stop-charge-thresh-batx
        # https://linrunner.de/tlp/settings/bc-vendors.html#lenovo-non-thinkpad-series
        START_CHARGE_THRESH_BAT0 = 0; # dummy value
        STOP_CHARGE_THRESH_BAT0 = 1;

      };
    };

    # Enable performance mode # Might need this for desktop?
    # powerManagement = {
    #   enable = true;
    #   cpuFreqGovernor = "performance"; # "ondemand", "powersave", "performance"
    # };

    # Install dependencies
    environment.systemPackages = dependencies;
  };
}

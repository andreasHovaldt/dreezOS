{ pkgs, lib, config, ... }:
let
  cfg = config.gaming;
  dependencies = with pkgs; [ ] ++
    lib.optionals cfg.steam.enable [ protonup-qt ] ++ # GUI for installing custom Proton versions like GE_Proton
    lib.optionals cfg.minecraft.enable [ prismlauncher ]; # https://wiki.nixos.org/wiki/Prism_Launcher
in
{
  options.gaming = {
    enable = lib.mkEnableOption "enable gaming config";
    steam.enable = lib.mkEnableOption "enable steam";
    minecraft.enable = lib.mkEnableOption "enable minecraft";
  };

  config = lib.mkIf cfg.enable {

    # Assertion to ensure NVIDIA driver is enabled
    assertions = [
      {
        assertion = config.nvidia.enable == true;
        message = "The 'nvidia' video driver module must be enabled for gaming.";
      }
    ];
    
    # Steam setup
    programs.steam = lib.mkIf cfg.steam.enable {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };

    # Install dependencies
    environment.systemPackages = dependencies;
  };
}

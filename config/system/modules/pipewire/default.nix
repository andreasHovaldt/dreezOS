{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    pavucontrol
  ];
in
{
  options = {
    pipewire.enable = lib.mkEnableOption "enable pipewire";
  };

  config = lib.mkIf config.pipewire.enable {

    # Enable sound with pipewire.
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };


    # Install dependencies
    environment.systemPackages = dependencies;
  };
}

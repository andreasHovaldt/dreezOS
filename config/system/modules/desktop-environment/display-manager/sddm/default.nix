{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    # sddm-sugar-dark dependencies
    # libsForQt5.qt5.qtquickcontrols2
    # libsForQt5.qt5.qtgraphicaleffects
  ];
in
{
  options = {
    sddm.enable = lib.mkEnableOption "enable sddm";
  };

  config = lib.mkIf config.sddm.enable {

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the sddm display manager.
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      settings.General.DisplayServer = "wayland";
      #theme = "${import ./themes/sddm-sugar-dark.nix { inherit pkgs; }}";
    };

    # Install dependencies
    environment.systemPackages = dependencies;
  };
}

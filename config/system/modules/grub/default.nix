{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [ ];
in
{
  options = {
    grub.enable = lib.mkEnableOption "enable grub";
  };

  config = lib.mkIf config.grub.enable {

    boot.loader = {
      grub = {
        enable = true;
        useOSProber = true;
        efiSupport = true;
        default = "saved"; # Boot last selected entry
        configurationLimit = 50;
        device = "nodev";
      };
      efi.canTouchEfiVariables = true;
    };

    # Install dependencies
    environment.systemPackages = dependencies;
  };
}

{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [ ];
in
{
  options = {
    gnupg.enable = lib.mkEnableOption "enable gnupg";
  };

  config = lib.mkIf config.gnupg.enable {

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    # Install dependencies
    environment.systemPackages = dependencies;
  };
}

{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    ## -- Write pkgs dependencies here -- ##



    ## -- End of dependencies -- ##
  ];
in
{
  options = {
    gdm.enable = lib.mkEnableOption "enable gdm";
  };

  config = lib.mkIf config.gdm.enable {
    ## -- Write your configuration here -- ##



    ## -- End of configuration -- ##

    # Install dependencies
    environment.systemPackages = dependencies;
  };
}

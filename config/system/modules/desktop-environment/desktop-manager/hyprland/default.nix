{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    ## -- Write pkgs dependencies here -- ##



    ## -- End of dependencies -- ##
  ];
in
{
  options = {
    hyprland.enable = lib.mkEnableOption "enable hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    ## -- Write your configuration here -- ##



    ## -- End of configuration -- ##

    # Install dependencies
    environment.systemPackages = dependencies;
  };
}

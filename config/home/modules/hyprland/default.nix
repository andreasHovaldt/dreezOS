{ pkgs, lib, config, ... }:
let
  cfg = config.hyprland;
  dependencies = with pkgs; [
    ## -- Write pkgs dependencies here -- ##



    ## -- End of dependencies -- ##
  ];
in
{
  options = {
    hyprland.enable = lib.mkEnableOption "enable hyprland";
  };

  config = lib.mkIf cfg.enable {
    ## -- Write your configuration here -- ##



    ## -- End of configuration -- ##

    # Install dependencies
    home.packages = dependencies;
  };
}

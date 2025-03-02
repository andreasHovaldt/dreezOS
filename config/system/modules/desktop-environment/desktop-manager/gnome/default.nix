{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    ## -- Write pkgs dependencies here -- ##



    ## -- End of dependencies -- ##
  ];
in
{
  options = {
    gnome.enable = lib.mkEnableOption "enable gnome";
  };

  config = lib.mkIf config.gnome.enable {
    ## -- Write your configuration here -- ##



    ## -- End of configuration -- ##

    # Install dependencies
    environment.systemPackages = dependencies;
  };
}

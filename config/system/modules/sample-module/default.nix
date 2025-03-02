{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    ## -- Write pkgs dependencies here -- ##



    ## -- End of dependencies -- ##
  ];
in
{
  options = {
    sample-module.enable = lib.mkEnableOption "enable sample-module";
  };

  config = lib.mkIf config.sample-module.enable {
    ## -- Write your configuration here -- ##



    ## -- End of configuration -- ##

    # Install dependencies
    environment.systemPackages = dependencies;
  };
}

{ pkgs, lib, config, ... }:
let
  cfg = config.sample-module;
  dependencies = with pkgs; [
    ## -- Write pkgs dependencies here -- ##



    ## -- End of dependencies -- ##
  ];
in
{
  options = {
    sample-module.enable = lib.mkEnableOption "enable sample-module";
  };

  config = lib.mkIf cfg.enable {
    ## -- Write your configuration here -- ##



    ## -- End of configuration -- ##

    # Install dependencies
    home.packages = dependencies;
  };
}

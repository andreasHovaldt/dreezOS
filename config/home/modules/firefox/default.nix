{ pkgs, lib, config, inputs, ... }:
let
  dependencies = with pkgs; [
    ## -- Write pkgs dependencies here -- ##



    ## -- End of dependencies -- ##
  ];
in
{
  options = {
    firefox.enable = lib.mkEnableOption "enable sample-module";
  };

  config = lib.mkIf config.sample-module.enable {
    ## -- Write your configuration here -- ##

    programs.firefox = {
      enable = true;

      profiles.dreezy = {
        extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
          lastpass-password-manager
          ublock-origin
          darkreader
          return-youtube-dislikes
          youtube-nonstop
        ];
      };
    };

    ## -- End of configuration -- ##

    # Install dependencies
    home.packages = dependencies;
  };
}

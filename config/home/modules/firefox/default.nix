{ pkgs, lib, config, inputs, ... }:
let
  dependencies = with pkgs; [
    ## -- Write pkgs dependencies here -- ##



    ## -- End of dependencies -- ##
  ];
in
{
  options = {
    firefox.enable = lib.mkEnableOption "enable firefox";
  };

  config = lib.mkIf config.firefox.enable {
    ## -- Write your configuration here -- ##

    nixpkgs.config = {
      allowUnfree = true;
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "lastpass-password-manager"
      ];
    };

    programs.firefox = {
      enable = true;

      profiles.dreezy = {
        extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
          #lastpass-password-manager
          ublock-origin
          darkreader
          return-youtube-dislikes
          youtube-nonstop
          privacy-badger
        ];
      };
    };

    ## -- End of configuration -- ##

    # Install dependencies
    home.packages = dependencies;
  };
}

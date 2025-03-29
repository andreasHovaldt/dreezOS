{ pkgs, lib, config, ... }:
let
  cfg = config.ghostty;
  dependencies = with pkgs; [
    ghostty
  ];
in
{
  options = {
    ghostty.enable = lib.mkEnableOption "enable ghostty";
  };

  config = lib.mkIf cfg.enable {

    programs.ghostty = {
      enable = true;

      settings = {
        clipboard-read = "allow";
        clipboard-write = "allow";
        #mouse-hide-while-typing = true;
        gtk-single-instance = true; # morty hack for speedup
      };
    };

    # Install dependencies
    home.packages = dependencies;
  };
}

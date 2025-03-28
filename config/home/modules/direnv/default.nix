{ pkgs, lib, config, ... }:
let
  cfg = config.direnv;
  dependencies = with pkgs; [ ];
in
{
  options = {
    direnv.enable = lib.mkEnableOption "enable direnv";
  };

  config = lib.mkIf cfg.enable {

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableBashIntegration = lib.mkIf (config.shell.bash.enable) true;
      enableZshIntegration = lib.mkIf (config.shell.zsh.enable) true;
    };

    # Install dependencies
    home.packages = dependencies;
  };
}

{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [ ];
in
{
  options = {
    basics.enable = lib.mkEnableOption "enable basics";
  };

  config = lib.mkIf config.basics.enable { };
}

{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    docker-compose
  ];
in
{
  options = {
    docker.enable = lib.mkEnableOption "enable docker";
  };

  config = lib.mkIf config.docker.enable {
    virtualisation.docker = {
      enable = true;

      rootless = {
        enable = true;
        setSocketVariable = true;
      };

      daemon.settings = {
        data-root = "/var/lib/docker";
      };
    };
  };
}

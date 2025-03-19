{ pkgs, lib, config, ... }:
let
  cfg = config.ssh;
  dependencies = with pkgs; [ gnome-keyring ];

  sshConfig = "${config.home.homeDirectory}/.config/ssh/config";
in
{
  options = {
    ssh.enable = lib.mkEnableOption "enable ssh";
  };

  config = lib.mkIf cfg.enable {

    home.file.".config/ssh/config" = {
      source = ./config;
    };

    # https://mynixos.com/home-manager/options/programs.ssh
    programs.ssh = {
      enable = true;
      addKeysToAgent = "yes"; # Adds newly used keys to the agent for future use 
      forwardAgent = true; # https://docs.github.com/en/authentication/connecting-to-github-with-ssh/using-ssh-agent-forwarding
      includes = [ sshConfig ];
    };

    # Install dependencies
    home.packages = dependencies;
  };
}

{ pkgs, lib, config, ... }:
let
  cfg = config.ssh;
  dependencies = with pkgs; [ ];

  sshConfig = "${config.home.homeDirectory}/.config/ssh/config";
  sshAddKeys = "${config.home.homeDirectory}/.config/ssh/add-keys";
in
{
  options = {
    ssh.enable = lib.mkEnableOption "enable ssh";
  };

  config = lib.mkIf cfg.enable {

    home.file = {
      ".config/ssh/config" = {
        source = ./config;
      };
      ".config/ssh/add-keys" = {
        source = ./add-keys;
        executable = true;
      };
    };


    # https://mynixos.com/home-manager/options/programs.ssh
    programs.ssh = {
      enable = true;
      addKeysToAgent = "yes"; # Adds newly used keys to the agent for future use 
      forwardAgent = true; # https://docs.github.com/en/authentication/connecting-to-github-with-ssh/using-ssh-agent-forwarding
      includes = [ sshConfig ];
    };

    systemd.user.services = {
      ssh-auto-key = {
        Unit = {
          Description = "Auto add ssh keys to the agent";
        };
        Service = {
          Type = "oneshot";
          ExecStart = ''
            /bin/sh ${sshAddKeys}
          '';
          StandardOutput = "journal";
          StandardError = "journal";
        };
      };
    };

    # Install dependencies
    home.packages = dependencies;
  };
}

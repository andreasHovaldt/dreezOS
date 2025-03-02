{ pkgs, lib, inputs, config, ... }:
let
  dependencies = with pkgs; [ ];
in
{
  options = {
    bash.enable = lib.mkEnableOption "enable bash";
  };

  config = lib.mkIf config.bash.enable
    {

      programs.bash = {
        enable = true;
        shellAliases = {
          # Wireguard
          dreez_connect = "sudo wg-quick up /root/wireguard-keys/dreez-wg0.conf";
          dreez_disconnect = "sudo wg-quick down /root/wireguard-keys/dreez-wg0.conf";

          # AAU VPN
          aau-vpn = "sudo openconnect --protocol=anyconnect SSL-VPN1.AAU.DK";

          # Git
          gsta = "git status";
        };
      };

      # Install dependencies
      home.packages = dependencies;
    }
    }

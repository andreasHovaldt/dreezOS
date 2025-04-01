{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    pkgs.networkmanagerapplet
    gnome-keyring

    # VPN pkgs # TODO: Maybe move to a separate module
    openconnect
    wireguard-tools
  ];
in
{
  options = {
    network.enable = lib.mkEnableOption "enable network";
  };

  config = lib.mkIf config.network.enable {

    # Enable networking
    networking.networkmanager.enable = true;

    # Enable mtr ping and traceroute
    programs.mtr.enable = true;

    # Enable the ssh-agent
    programs.ssh.startAgent = true;

    # Open ports in the firewall
    networking.firewall.allowedTCPPorts = [
      # 22 # SSH
      # 80 # HTTP
      # 443 # HTTPS
      # 8786 # Dask worker
    ];

    # Install dependencies
    environment.systemPackages = dependencies;
  };
}






# Enables wireless support via wpa_supplicant.
# networking.wireless.enable = true;

# Enable the OpenSSH daemon.
# services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

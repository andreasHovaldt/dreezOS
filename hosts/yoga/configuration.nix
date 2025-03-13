# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }: {

  networking.hostName = "yoga";

  imports =
    [
      ./hardware-configuration.nix
      ../../config/system/default.nix
      ./cachix.nix
    ];

  # Bootloader modules - Choose one
  grub.enable = true;
  systemd-boot.enable = false;

  # System basics
  basics.enable = true;

  # Display manager
  gdm.enable = true;
  sddm.enable = false;

  # Desktop manager
  gnome.enable = true;
  kde-plasma6.enable = false;


  # System modules
  power.enable = true;
  network.enable = true;
  pipewire.enable = true;
  bluetooth.enable = true;
  nvidia.enable = true;
  docker.enable = false;
  gnupg.enable = false;
  services.printing.enable = true;
  programs.firefox.enable = true;
  programs.direnv.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dreezy = {
    isNormalUser = true;
    description = "Andreas Højrup";
    extraGroups = [ "networkmanager" "wheel" ];
    # shell = pkgs.zsh; # TODO: Research this
  };

  # System packages
  environment.systemPackages = with pkgs; [
    nixpkgs-fmt
    cachix
  ];

  # Swap
  swapDevices = [{
    device = "/swapfile";
    size = 16 * 1024;
  }];

  # Before changing this value read the documentation for this option
  system.stateVersion = "24.11";

}

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }: {

  networking.hostName = "yoga";

  imports =
    [
      ./hardware-configuration.nix
      ../../config/system/default.nix
    ];

  # Bootloader
  systemd-boot.enable = true;

  # System basics
  basics.enable = true;

  # Desktop environment
  sddm.enable = true;
  hyprland.enable = true;
  stylix-theme.enable = true;

  # System modules
  power.enable = true;
  network.enable = true;
  pipewire.enable = true;
  bluetooth.enable = true;
  nvidia.enable = true;
  thunar.enable = true;
  docker.enable = false;
  gaming.enable = false;
  gnupg.enable = false;
  services.printing.enable = true;
  services.envfs.enable = false; # Should help resolve shebangs !/bin/bash
  programs.firefox.enable = true;
  programs.direnv.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dreezy = {
    isNormalUser = true;
    description = "Andreas Højrup";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  # Swap
  swapDevices = [{
    device = "/swapfile";
    size = 16 * 1024;
  }];

  # Before changing this value read the documentation for this option
  system.stateVersion = "24.11";

}

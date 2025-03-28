{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    wget
    git
    htop
    tmux
    nixpkgs-fmt
    font-awesome
  ];
in
{
  options = {
    basics.enable = lib.mkEnableOption "enable basics";
  };

  config = lib.mkIf config.basics.enable {

    # Set your time zone.
    time.timeZone = "Europe/Copenhagen";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_DK.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "da_DK.UTF-8";
      LC_IDENTIFICATION = "da_DK.UTF-8";
      LC_MEASUREMENT = "da_DK.UTF-8";
      LC_MONETARY = "da_DK.UTF-8";
      LC_NAME = "da_DK.UTF-8";
      LC_NUMERIC = "da_DK.UTF-8";
      LC_PAPER = "da_DK.UTF-8";
      LC_TELEPHONE = "da_DK.UTF-8";
      LC_TIME = "da_DK.UTF-8";
    };

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "dk";
      variant = "";
    };

    # Configure console keymap
    console.keyMap = "dk-latin1";

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Enable zsh
    programs.zsh.enable = true;

    # Enable OpenGL
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    # Enable seatd as Seat Manager
    # This is supposedly required for Hyprland to work properly
    # remember to add your user to the "seat" group
    #services.seatd.enable = true;

    # Garbage collection
    nix.gc = {
      automatic = true; # Enable automatic cleanup
      persistent = true; # Ensures GC job persists across suspend, reboot, shutdown
      dates = "05:00:00"; # Queues daily cleanup job at 5 AM
      options = "--delete-older-than 3d"; # Deletes system generations older than 7 days
    };
    nix.settings.auto-optimise-store = true;

    # Enable experimental features
    nix.settings.experimental-features = [ "nix-command" "flakes" ];


    # Desktop portals handle interactions between desktop programs
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
      xdgOpenUsePortal = true;
    };


    # Install dependencies
    environment.systemPackages = dependencies;
  };
}

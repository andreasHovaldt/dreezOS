{ pkgs, lib, config, ... }:
let
  username = "dreezy";
  staticWallpaper = config.home-manager.users.${username}.wpaperd.staticWallpaper;
  globalWallpaper = "sddm/background.jpg"; # Gets written to "/etc/<globalWallpaper>"
in
{
  options = {
    sddm.enable = lib.mkEnableOption "enable sddm";
  };

  config = lib.mkIf config.sddm.enable {
    
    # Make background available at boot
    environment.etc."${globalWallpaper}".source = staticWallpaper;

    # Enable the X11 windowing system.
    services.xserver.enable = true;


    # Notes regarding better theme
    # - https://github.com/Keyitdev/sddm-astronaut-theme
    # - https://github.com/Keyitdev/sddm-astronaut-theme/blob/master/Themes/astronaut.conf
    # - https://github.com/DaniD3v/system-dotfiles/blob/master/common%2Fsddm.nix
    # - https://github.com/NixOS/nixpkgs/issues/343702
    

    # Enable the sddm display manager.
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm; # Use qt6 version of sddm
      enableHidpi = true;
      theme = "catppuccin-mocha";
      #settings.General.DisplayServer = "wayland";
    };

    # Install dependencies
    environment.systemPackages = [(
      pkgs.catppuccin-sddm.override {
        flavor = "mocha";
        font  = "Noto Sans";
        fontSize = "9";
        background = "/etc/${globalWallpaper}"; # FIXME: Doesn't get applied?
        loginBackground = true;
      }
    )];
  };
}

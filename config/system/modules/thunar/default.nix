{ pkgs, lib, config, ... }:
let
  cfg = config.thunar;
  dependencies = with pkgs; [ 
    unzip
    zip
    p7zip
    unrar
    gzip
    bzip2
  ];
in
{
  options = {
    thunar.enable = lib.mkEnableOption "enable thunar";
  };

  config = lib.mkIf cfg.enable {

    # https://wiki.nixos.org/wiki/Thunar
    programs.xfconf.enable = true;
    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-volman # Thunar extension for automatic management of removable drives and media
        thunar-archive-plugin # Thunar plugin providing file context menus for archives
        thunar-media-tags-plugin # Thunar plugin providing tagging and renaming features for media files
      ];
    };

    programs.file-roller.enable = true; # An archive manager from GNOME
    services.gvfs.enable = true; # Mount, trash, and other functionalities
    services.tumbler.enable = true; # Thumbnail support for images

    # Install dependencies
    environment.systemPackages = dependencies;
  };
}

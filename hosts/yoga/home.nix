{ config, pkgs, ... }:

{
  # Let Home Manager manage the user's home directory.
  home = {
    username = "dreezy";
    homeDirectory = "/home/dreezy";
    stateVersion = "24.11";
    sessionVariables = {
      EDITOR = "nano";
      NIXPKGS_ALLOW_UNFREE = "1";
    };
  };

  # Import Home Manager modules.
  imports = [
    ../../config/home/default.nix
  ];

  # Enable Home Manager modules.
  shell.enable = true;
  terminal = {
    enable = true;
    ghostty.enable = true;
    kitty.enable = false;
    alacritty.enable = false;
  };
  tmux.enable = true;
  git.enable = true;
  stylix-theme.enable = false;
  hyprland.enable = true;
  ssh.enable = true;
  direnv.enable = true;

  # Misc Home Manager packages.
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # Util
    yazi
    neofetch
    fastfetch

    # Programs
    discord
    vlc
    vscode
    evince
    spotify
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

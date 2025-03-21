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
  bash.enable = true;
  git.enable = true;
  ghostty.enable = true;
  tmux.enable = true;
  hyprland.enable = true;
  swww.enable = false;
  ssh.enable = true;
  firefox.enable = false; # Instead, use the system Firefox and login
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
  };

  # Home Manager packages.
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # Util
    yazi
    neofetch

    # Programs
    discord
    vlc
    vscode
    evince
    spotify
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = { };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

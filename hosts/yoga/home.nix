{
  config,
  pkgs,
  ...
}: {
  # Let Home Manager manage the user's home directory
  home = {
    username = "dreezy";
    homeDirectory = "/home/dreezy";
    stateVersion = "24.11";
    sessionVariables = {
      EDITOR = "nano";
      NIXPKGS_ALLOW_UNFREE = "1";
    };
  };

  # Import Home Manager modules
  imports = [
    ../../config/home/default.nix
  ];

  # Home Manager modules
  shell.enable = true;
  terminal = {
    enable = true;
    wezterm.enable = true;
    ghostty.enable = false;
    kitty.enable = false;
    alacritty.enable = false;
  };
  tmux.enable = true;
  git.enable = true;
  ssh.enable = true;
  direnv.enable = true;

  # Desktop environment
  stylix-theme.enable = true; # Theming
  hyprland.enable = true; # Window manager
  hyprlock.enable = true; # Lock screen
  wpaperd.enable = true; # Wallpaper manager
  waybar.enable = true; # Status bar
  swaync.enable = true; # Notification center

  # Misc Home Manager packages
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

  xdg.userDirs = {
    enable = true;
    desktop = null;
    documents = "${config.home.homeDirectory}/Documents";
    download = "${config.home.homeDirectory}/Downloads";
    music = null;
    pictures = "${config.home.homeDirectory}/Pictures";
    publicShare = null;
    templates = null;
    videos = null;
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}

{
  config,
  pkgs,
  unstablePkgs,
  inputs,
  ...
}: {
  # Let Home Manager manage the user's home directory
  home = {
    username = "dreezy";
    homeDirectory = "/home/dreezy";
    stateVersion = "24.11";
    sessionVariables = {
      TERMINAL = "wezterm";
      EDITOR = "code";
      BROWSER = "firefox";
      NIXPKGS_ALLOW_UNFREE = "1";
    };
  };

  # Import Home Manager modules
  imports = [
    ../../config/home/default.nix
    inputs.nvf.homeManagerModules.default
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
  nvf.enable = true;
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
    desktop = "${config.home.homeDirectory}/Desktop";
    documents = "${config.home.homeDirectory}/Documents";
    download = "${config.home.homeDirectory}/Downloads";
    music = "${config.home.homeDirectory}/Music";
    pictures = "${config.home.homeDirectory}/Pictures";
    publicShare = "${config.home.homeDirectory}/Public";
    templates = "${config.home.homeDirectory}/Templates";
    videos = "${config.home.homeDirectory}/Videos";
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}

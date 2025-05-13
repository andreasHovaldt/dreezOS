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

  # Desktop environment
  stylix-theme.enable = true; # Theming
  hyprland.enable = true; # Window manager
  hyprlock.enable = true; # Lock screen
  wpaperd.enable = true; # Wallpaper manager
  waybar.enable = true; # Status bar
  swaync.enable = true; # Notification center

  # Home Manager modules
  shell.enable = true;
  terminal = {
    enable = true;
    wezterm.enable = true;
    ghostty.enable = false;
    kitty.enable = false;
    alacritty.enable = false;
  };
  nvf.enable = false;
  tmux.enable = false;
  git.enable = true;
  ssh.enable = true;
  direnv.enable = true;

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

  # Set default apps for mime types
  # https://mimetype.io/all-types
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/plain" = "code.desktop";
      "text/css" = "code.desktop";
      "text/csv" = "code.desktop";
      "text/javascript" = "code.desktop";
      "text/markdown" = "code.desktop";
      "text/x-c" = "code.desktop";
      "text/x-fortran" = "code.desktop";
      "text/x-java-source" = "code.desktop";
      "text/x-pascal" = "code.desktop";
      "text/x-python" = "code.desktop";
      "text/html" = [ "firefox.desktop" "code.desktop"];

      "application/x-sh" = "code.desktop";
      "application/x-tex" = "code.desktop";
      "application/yaml" = "code.desktop";
      "application/json" = "code.desktop";
      "application/xml" = "code.desktop";
    };
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}

{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dreezy";
  home.homeDirectory = "/home/dreezy";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    discord
    vlc
    vscode
    evince
    spotify
    yazi
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = { };

  programs.bash = {
    enable = true;
    shellAliases = {
      # Wireguard
      dreez_connect = "sudo wg-quick up /root/wireguard-keys/dreez-wg0.conf";
      dreez_disconnect = "sudo wg-quick down /root/wireguard-keys/dreez-wg0.conf";

      # AAU VPN
      aau-vpn = "sudo openconnect --protocol=anyconnect SSL-VPN1.AAU.DK";

      # Git
      gsta = "git status";
    };
  };

  programs.git = {
    enable = true;
    userName = "andreasHovaldt";
    userEmail = "andreas.hovaldt@gmail.com";

    aliases = {
      pu = "push";
      co = "checkout";
      cm = "commit";
      sta = "status";
    };

    ignores = [
      "**/.vscode/**"
      "**/__pycache__/**"
      "**/.direnv/**"
    ];

    extraConfig = {
      core.editor = "code";
      pull.rebase = true;
    };
  };

  programs.ghostty = {
    enable = true;

    settings = {
      clipboard-read = "allow";
      clipboard-write = "allow";
      copy-on-select = true;
      background-opacity = 0.85;
      background-blur = 20;
      mouse-hide-while-typing = true;

      window-theme = "dark";
      theme = "tokyonight";
      #theme = "midnight-in-mojave";
      #theme = "iTerm Smoooooth";
      minimum-contrast = 2;
      background = "#1a1b26";
      foreground = "#c0caf5";
      selection-background = "#33467c";
      selection-foreground = "#c0caf5";
      cursor-color = "#c0caf5";
      cursor-text = "#15161e";
      cursor-style = "bar";
      palette = [
        "0=#15161e"
        "1=#f7768e"
        "2=#9ece6a"
        "3=#e0af68"
        "4=#7aa2f7"
        "5=#bb9af7"
        "6=#7dcfff"
        "7=#a9b1d6"
        "8=#414868"
        "9=#f7768e"
        "10=#9ece6a"
        "11=#e0af68"
        "12=#7aa2f7"
        "13=#bb9af7"
        "14=#7dcfff"
        "15=#c0caf5"
        "16=#3ddbd9"
      ];
    };
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.tmux = {
    enable = true;
    mouse = true; # Default: false
    clock24 = true; # Default: false

    ### tmux-sensible settings ###
    escapeTime = 0; # Default: 500
    historyLimit = 50000; # Default: 2000
    terminal = "screen-256color"; # Default: screen
    aggressiveResize = true; # Default: false
    keyMode = "emacs"; # Default: emacs
    shortcut = "b"; # Default: b
    ##############################


    plugins = [
      pkgs.tmuxPlugins.yank
    ];

    extraConfig = ''
      # Window splitting
      bind h split-window -h
      bind v split-window -v

      # Window creation
      unbind "w"
      unbind "c"
      bind w new-window
      bind l choose-window

      # Increase tmux messages display duration from 750ms to 4s
      # from: https://github.com/tmux-plugins/tmux-sensible
      set -g display-time 4000

      # Refresh 'status-left' and 'status-right' more often, from every 15s to 5s
      # from: https://github.com/tmux-plugins/tmux-sensible
      set -g status-interval 5

      # Plugins
      # from: https://github.com/tmux-plugins/tmux-yank/issues/172#issuecomment-1827825691
      set -g set-clipboard on
      set -g @override_copy_command 'xclip -i -selection clipboard'
      set -g @yank_selection 'clipboard'
      set -as terminal-features ',*:clipboard'
    '';


  };

  home.sessionVariables = {
    EDITOR = "nano";
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  home.stateVersion = "24.11"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

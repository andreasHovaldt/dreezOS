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
    # Util
    yazi
    neofetch

    # Programs
    ghostty
    discord
    vlc
    vscode
    evince
    spotify
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
      init.defaultBrach = "main";
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
    mouse = true;
    clock24 = true;
    terminal = "tmux-256color";
    historyLimit = 100000;
    plugins = with pkgs;
      [
        tmuxPlugins.sensible
        tmuxPlugins.better-mouse-mode
        {
          plugin = tmuxPlugins.yank;
          extraConfig = ''
            # from: https://github.com/tmux-plugins/tmux-yank/issues/172#issuecomment-1827825691
            set -g set-clipboard on
            set -g @override_copy_command 'xclip -i -selection clipboard'
            set -g @yank_selection 'clipboard'
            set -as terminal-features ',*:clipboard'
          '';
        }
        tmuxPlugins.yank
      ];

    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"

      bind h split-window -h -c "#{pane_current_path}"
      bind v split-window -v -c "#{pane_current_path}"

      unbind w
      unbind c
      bind w new-window
      bind l choose-window

      # Easier reload of config
      bind r source-file ~/.config/tmux/tmux.conf

      # make Prefix p paste the buffer.
      unbind p
      bind p paste-buffer
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

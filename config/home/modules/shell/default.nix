{ pkgs, lib, config, ... }:
let
  cfg = config.shell;
  dependencies = with pkgs; [
    zoxide
    fzf
    starship
  ];

  aliases = {
    # Wireguard
    dreez_connect = "sudo wg-quick up /root/wireguard-keys/dreez-wg0.conf";
    dreez_disconnect = "sudo wg-quick down /root/wireguard-keys/dreez-wg0.conf";

    # AAU VPN
    aau-vpn = "sudo openconnect --protocol=anyconnect SSL-VPN1.AAU.DK";

    # Git
    gsta = "git status";

    # nixos-rebuild from flake
    nr-flake = "nixos-rebuild switch --use-remote-sudo --flake ./#$(hostname)";

    # open
    open = "xdg-open";

  };
in
{
  options.shell = {
    enable = lib.mkEnableOption "enable shell config";

    bash.enable = lib.mkOption {
      type = lib.types.bool;
      default = cfg.enable;
    };

    zsh.enable = lib.mkOption {
      type = lib.types.bool;
      default = cfg.enable;
    };
  };

  config = lib.mkIf cfg.enable {

    # Bash setup
    programs.bash = {
      enable = true;
      shellAliases = aliases;
      historySize = 20000;
      historyFile = "$HOME/.bash_history";
    };


    # Zsh theme
    programs.starship = {
      enable = true;
      settings = {
        add_newline = true;
        command_timeout = 1300;
        scan_timeout = 50;
      };
    };

    # Zsh setup
    programs.zsh = {
      enable = true;
      shellAliases = aliases;
      history = {
        save = 20000;
        size = 20000;
        path = "$HOME/.zsh_history";
        share = true;
        ignoreDups = true;
        ignoreSpace = true;
        ignoreAllDups = true;
      };

      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      oh-my-zsh = {
        enable = true;

        # https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
        plugins = [ "git-auto-fetch" "z" "fzf" "zsh-interactive-cd" "colored-man-pages" "sudo" ];
        # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git-auto-fetch
        # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/z
        # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/fzf
        # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/zsh-interactive-cd
        # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/colored-man-pages
        # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo
      };

      dotDir = ".config/zsh";

      initExtra = ''
        eval "$(zoxide init --cmd cd zsh)"
        eval "$(starship init zsh)"
      '';
    };

    # Install dependencies
    home.packages = dependencies;
  };
}

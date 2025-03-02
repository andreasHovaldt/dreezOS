{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [ ];
in
{
  options = {
    tmux.enable = lib.mkEnableOption "enable tmux";
  };

  config = lib.mkIf config.tmux.enable {

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

    # Install dependencies
    home.packages = dependencies;
  };
}

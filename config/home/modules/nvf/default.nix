{
  pkgs,
  unstablePkgs,
  lib,
  config,
  ...
}: let
  cfg = config.nvf;
  dependencies = with unstablePkgs; [
    neovim
    #vim
  ];
in {
  options = {
    nvf.enable = lib.mkEnableOption "enable nvf";
  };

  config = lib.mkIf cfg.enable {
    programs.nvf = {
      enable = true;

      settings.vim = {
        theme = {
          enable = true;
          name = "onedark";
          style = "dark";
        };

        # Language support
        languages = {
          #enableLSP = true;
          #enableFormat = true;
          #enableTreesitter = true;

          nix = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
            format.enable = true;
          };

          python = {
            enable = true;
            lsp.enable = true;
            lsp.server = "pyright";
            treesitter.enable = true;
            format.enable = false;
          };
        };

        # Plugins
        git.enable = true;

        statusline.lualine.enable = true; # Statusline
        telescope.enable = true; # Fuzzy search

        # autocomplete.nvim-cmp.enable = true;
        autocomplete.blink-cmp = {
          enable = true; # Completion menu
          friendly-snippets.enable = true;
        };
        autopairs.nvim-autopairs.enable = true; # Autopairing of brackets and such
        snippets.luasnip.enable = true; # Provides ability to autocomplete boilerplate code, defaults use preconfigured snippets from the "friendly-snippets" package

        filetree.nvimTree = {
          enable = true; # File explorer
          openOnSetup = true; # Open when vim is started on a directory
        };

        terminal.toggleterm = {
          enable = true; # Manage multiple terminal windows
          setupOpts.direction = "float"; # Makes the opened terminal a floating window
          mappings.open = "<c-t>"; # ctrl + t
        };

        # Configurations
        lsp = {
          enable = true;
          formatOnSave = true;
          inlayHints.enable = true;
          trouble.enable = true;
        };

        options = {
          tabstop = 4;
          shiftwidth = 0;
        };

        useSystemClipboard = true;
      };
    };

    # Install dependencies
    home.packages = dependencies;
  };
}

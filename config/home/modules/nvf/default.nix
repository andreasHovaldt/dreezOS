{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.nvf;
  dependencies = with pkgs; [neovim];
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

        # Plugins
        statusline.lualine.enable = true; # Statusline
        telescope.enable = true; # Fuzzy search
        autocomplete.nvim-cmp.enable = true; # Completion menu

        # Language support
        languages = {
          enableLSP = true;
          enableTreesitter = true;
          enableFormat = true;

          nix.enable = true;
          python.enable = true;
        };
      };
    };

    # Install dependencies
    home.packages = dependencies;
  };
}

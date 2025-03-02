{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [ ];
in
{
  options = {
    git.enable = lib.mkEnableOption "enable git";
  };

  config = lib.mkIf config.git.enable {

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

    # Install dependencies
    home.packages = dependencies;
  };
}

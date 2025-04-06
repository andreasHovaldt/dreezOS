{ pkgs, lib, config, ... }:
let
  cfg = config.waybar;

in
{
  options.waybar = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hyprland.enable;
      description = "Enable Waybar. Defaults to true if Hyprland is enabled.";
    };
  };

  config = lib.mkIf cfg.enable {

    # Disable default Stylix CSS for Waybar
    # https://stylix.danth.me/options/modules/waybar.html
    # https://github.com/danth/stylix/blob/9a3fb931fdfc5d6be48dc3c90fe775aada78efba/modules/waybar/hm.nix
    stylix.targets.waybar.addCss = false;

    # Waybar config
    programs.waybar = {
      enable = true;

      # https://github.com/Alexays/Waybar/wiki/
      settings = lib.importJSON ./src/config.json;
      style = lib.mkAfter (builtins.readFile ./src/style.css);
    };

    # Enable Waybar for Hyprland
    wayland.windowManager.hyprland.settings = lib.mkIf config.hyprland.enable {
      exec-once = [ "waybar" ];
    };
  };
}

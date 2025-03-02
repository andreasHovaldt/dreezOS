##################################################################
# UNCOMMENT: Has been commented out in ../modules/default.nix    #
#                                                                #
# ALSO: insert xremap-flake.url = "github:xremap/nix-flake";     #
#       in flake.nix under inputs                                #
#                                                                #
# AND: add xremap.enable = true; in hosts/yoga/configuration.nix #
##################################################################

{ pkgs, lib, config, inputs, ... }:
let
  dependencies = with pkgs; [
    ## -- Write pkgs dependencies here -- ##



    ## -- End of dependencies -- ##
  ];
in
{
  imports = [
    inputs.xremap-flake.nixosModules.default
  ];

  options = {
    xremap.enable = lib.mkEnableOption "enable xremap";
  };

  config = lib.mkIf config.xremap.enable {
    ## -- Write your configuration here -- ##

    services.xremap = {
      enable = true;
      withGnome = true;
      userName = "dreezy";
      config = {
        keymap = [
          {

            name = "general keybindings";
            remap = {
              super-g = {
                launch = [ "${lib.getExe pkgs.firefox}" ];
              };
            };
          }
        ];
      };
    };


    ## -- End of configuration -- ##

    # Install dependencies
    environment.systemPackages = dependencies;
  };
}

{ pkgs, lib, config, inputs, ... }:
let
  dependencies = with pkgs; [
    ## -- Write pkgs dependencies here -- ##



    ## -- End of dependencies -- ##
  ];
in
{
  options = {
    xremap.enable = lib.mkEnableOption "enable xremap";
  };

  config = lib.mkIf config.xremap.enable {
    ## -- Write your configuration here -- ##

    imports = [
      inputs.xremap-flake.nixosModules.default
    ];

    services.xremap = {
      enable = true;
      withGnome = true;
      userName = "dreezy";
      config = {
        keymap = {

          name = "Main remaps";
          remap = {
            C_ALT = {
              remap = {
                f = {
                  launch = [ "ghostty" ];
                };
              };
            };
          };

        }
          }
          }


          ## -- End of configuration -- ##

          # Install dependencies
          environment.systemPackages = dependencies;
      };
    }

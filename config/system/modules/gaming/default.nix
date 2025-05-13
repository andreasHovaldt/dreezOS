{ lib, config, ... }: 
let
  cfg = config.gaming;
in
{

  # options.cfg = {
  #   enable = lib.mkEnableOption "enable gaming modules";
  # };
  
  imports = [
    ./steam
    ./proton
    ./minecraft
    ./lutris
  ];

}

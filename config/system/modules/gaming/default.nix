{ lib, config, ... }: 
let
  cfg = config.gaming;
in
{
  
  imports = [
    ./steam
    ./proton
    ./minecraft
    ./lutris
  ];

}

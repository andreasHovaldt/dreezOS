{ pkgs }:

let
  imgLink = "https://raw.githubusercontent.com/AngelJumbo/gruvbox-wallpapers/refs/heads/main/wallpapers/irl/road.jpg";

  image = pkgs.fetchurl {
    url = imgLink;
    sha256 = "1cvancpcy844sz3qshyfkhr3wc47z1jkfmjwb7jhjk1h01qnzcqb";
  };
in
pkgs.stdenv.mkDerivation {

  name = "sddm-sugar-dark";

  # nix shell -p nix-prefetch-git
  # nix-prefetch-git https://github.com/MarianArlt/sddm-sugar-dark
  src = pkgs.fetchFromGitHub {
    owner = "MarianArlt";
    repo = "sddm-sugar-dark";
    rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
    sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
  };

  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
  '';

  # installPhase = ''
  #   mkdir -p $out
  #   cp -R ./* $out/
  #   cd $out/
  #   rm Background.jpg
  #   cp -r ${image} $out/Background.jpg
  # '';

}

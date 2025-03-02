The structuring of this NixOS config was inspired by [vimjoyer](https://www.youtube.com/watch?v=vYc6IzKvAJQ) and [flatrat24's repo](https://github.com/flatrat24/NixOS/tree/df60fdd58a52ba9b930e00d52fae26cc9e12b7d5)

## Rebuild system using this flake
```shell
git clone https://github.com/andreasHovaldt/dreezOS.git  
cd dreezOS
sudo nixos-rebuild switch --flake ./#yoga
```

## Check for updates on all pkgs
```shell
nix flake update
```

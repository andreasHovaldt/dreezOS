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

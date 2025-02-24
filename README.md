## Rebuild system using this flake
```shell
git clone https://github.com/andreasHovaldt/dreezOS.git  
cd dreezOS
sudo nixos-rebuild switch --flake ./#dreezOS
```
### or from anywhere
```shell
sudo nixos-rebuild switch --flake /path/to/git/dir/#dreezOS
```

## Check for updates on all pkgs
```shell
nix flake update
```

# Check for updates on all pkgs
```nix flake update```

# Rebuild system using this flake
```git clone https://github.com/andreasHovaldt/dreezOS.git```  
```cd dreezOS```  
```sudo nixos-rebuild switch --flake ./#dreezOS```
### or from anywhere
```sudo nixos-rebuild switch --flake ~/dreezOS/#dreezOS```

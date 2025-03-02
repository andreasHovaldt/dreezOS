{ ... }: {
  imports = [
    ./modules/basics
    ./modules/nvidia
    ./modules/docker
    ./modules/network
    ./modules/grub
    ./modules/systemd-boot
    ./modules/gnome
    ./modules/pipewire
    ./modules/power
    ./modules/gnupg
    ./modules/xremap
  ];
}

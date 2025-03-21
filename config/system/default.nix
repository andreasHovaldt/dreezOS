{ ... }: {
  imports = [
    ./modules/basics
    ./modules/nvidia
    ./modules/docker
    ./modules/network
    ./modules/grub
    ./modules/systemd-boot
    ./modules/pipewire
    ./modules/power
    ./modules/gnupg
    #./modules/xremap
    ./modules/bluetooth
    ./modules/cachix

    ./modules/desktop-environment/hyprland
    ./modules/desktop-environment/display-manager/gdm
    ./modules/desktop-environment/display-manager/sddm
    ./modules/desktop-environment/desktop-manager/gnome
    ./modules/desktop-environment/desktop-manager/kde-plasma6
    #./modules/desktop-environment/display-manager/lightdm # TODO: Research this
  ];
}

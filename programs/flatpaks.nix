{ inputs, ... }:
{
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  services.flatpak.update.auto.enable = true;
  services.flatpak.uninstallUnmanaged = true;

  services.flatpak.packages = [
    "org.vinegarhq.Sober"
  ];
}
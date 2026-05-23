{ inputs, ... }:
{
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  services.flatpak.update.onActivation = true;
  services.flatpak.uninstallUnmanaged = true;

  services.flatpak.packages = [
    "org.vinegarhq.Sober"
    "sh.ppy.osu"
  ];
}

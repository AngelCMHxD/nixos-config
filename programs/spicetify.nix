{ inputs, pkgs, ... }:
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify
  ];

  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
  in {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      copyToClipboard
      adblock
      beautifulLyrics
    ];

    theme = spicePkgs.themes.comfy;
    colorScheme = "catppuccin-macchiato";
  };
}
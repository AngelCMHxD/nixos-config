{ pkgs, ... }:
{
  xdg.configFile."fish/themes".source = ./themes;
  programs.fish = {
    enable = true;
    shellAliases = {
      nixos-rebuild-switch = "sudo nixos-rebuild switch --flake /etc/nixos#ichigo";
      nixos-rebuild-boot = "sudo nixos-rebuild boot --flake /etc/nixos#ichigo";
      get-extension-id = "${pkgs.bash}/bin/bash ${../zen-browser/get-extension-id.sh}";
    };
    shellInit = builtins.readFile ./config.fish;
  };

}
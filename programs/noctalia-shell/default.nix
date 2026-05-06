{ inputs, pkgs, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  home.packages = with pkgs; [
    fd # File searching utility. For the Noctalia file-search plugin. https://noctalia.dev/plugins/file-search
  ];
  
  xdg.configFile."noctalia/settings.json".source = ./settings.json; # TODO: Move Noctalia settings to Home Manager
  programs.noctalia-shell = {
    enable = true;
    plugins = {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = {
        polkit-agent = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        clipboard = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        privacy-indicator = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        file-search = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        github-feed = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
      version = 2;
    };
  };
}
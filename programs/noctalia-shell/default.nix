{ inputs, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default
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
      };
      version = 2;
    };
  };
}
{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.noctalia.homeModules.default
    inputs.zen-browser.homeModules.beta
    inputs.nixcord.homeModules.nixcord
  ];

  home.username = "angel";
  home.homeDirectory = "/home/angel";

  xdg.configFile."niri/config.kdl".source = ./niri.kdl;
  xdg.configFile."niri/config.kdl".force = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    
    matchBlocks = {
      "github.com" = {
        addKeysToAgent = "yes";
	identityFile = "~/.ssh/id_ed25519";
      };
    };
  };

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

  # Matched the system.stateVersion on configuration.nix
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    zed-editor # TODO: Move settings to Home Manager
    neovim
    python3
    ghostty # TODO: Move settings to Home Manager
  ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
  };

  programs.git = {
    enable = true;
    signing = {
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
    };
    settings = {
      init.defaultBranch = "main";
      gpg.format = "ssh";
      user = {
        name = "Angel";
        email = "57822483+AngelCMHxD@users.noreply.github.com";
      };
    };
  };

  programs.nixcord = {
    enable = true;

    discord.vencord.enable = false;
    discord.equicord.enable = true;

    quickCss = "@import url(\"https://catppuccin.github.io/discord/dist/catppuccin-macchiato.theme.css\");";
    config = {
      useQuickCss = true;

      plugins = {

        questify = {
          enable = true;

          questRewardIncludeCollectibles = false;
          questRewardIncludeInGame = false;
          questRewardIncludeRewardCode = false;

          completeAchievementQuestsInBackground = true;
          completeGameQuestsInBackground = true;
          completeVideoQuestsInBackground = true;
          completeVideoQuestsQuicker = true;

          disableQuestsPageSponsoredBanner = true;
          disableQuestsDiscoveryTab = true;
          disableQuestsDirectMessagesTab = true;
        };

        # Youtube patches
        fixYoutubeEmbeds.enable = true;
        youtubeAdblock.enable = true;
        dearrow.enable = true;

        # Spotify
        fixSpotifyEmbeds.enable = true;
        spotifyCrack.enable = true;

        consoleJanitor.enable = true;
        experiments.enable = true;
        noDevtoolsWarning.enable = true;
      };
    };
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      nixos-rebuild-switch = "sudo nixos-rebuild switch --flake /etc/nixos#ichigo";
      nixos-rebuild-boot = "sudo nixos-rebuild boot --flake /etc/nixos#ichigo";
    };
  };

  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        jnoortheen.nix-ide
      ];
      
      userSettings = {
        "nix.enableLanguageServer" = true;
	"workbench.colorTheme" = "Catppuccin Macchiato";
	"workbench.iconTheme" = "catppuccin-macchiato";
      };
    };
  };

  programs.home-manager.enable = true;
}

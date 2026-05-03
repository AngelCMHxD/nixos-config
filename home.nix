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
    inputs.spicetify-nix.homeManagerModules.spicetify
  ];

  home.username = "angel";
  home.homeDirectory = "/home/angel";

  xdg.configFile."niri/config.kdl".source = ./niri.kdl; # TODO: Move Noctalia settings to Nix language (using a Niri flake)

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

  xdg.configFile."noctalia/settings.json".source = ./noctalia-settings.json; # TODO: Move Noctalia settings to Home Manager
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
    neovim
    kdePackages.partitionmanager
    python3

    # Fonts
    nerd-fonts.jetbrains-mono
    inter
  ];

  programs.ghostty = {
    enable = true;
    
    settings = {
      custom-shader = "/etc/nixos/cursor_warp.glsl";
      font-family = "JetBrainsMono Nerd Font";
      adjust-cursor-thickness = 3;
      quit-after-last-window-closed = false;
    };
  };

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

  programs.zed-editor = {
    enable = true;

    extensions = [
      "catppuccin"
      "catppuccin-icons"
      "discord-presence"
    ];

    userSettings = {
      cli_default_open_behavior = "new_window";
      project_panel = {
        dock = "left";
        sort_mode = "directories_first";
        hide_hidden = false;
        hide_root = false;
        indent_guides.show = "always";

        git_status_indicator = true;
        diagnostic_badges = false;
        bold_folder_labels = true;
        auto_fold_dirs = false;

        indent_size = 15;

        git_status = true;
        folder_icons = true;
        file_icons = true;
        entry_spacing = "standard";
      };

      languages.Python.format_on_save = "off";
      inlay_hints = {};

      lsp = {
        discord_presence = {
          initialization_options = {
            details = "Working on a {language:u} file";
            state = ":P";
          };
        };
      };

      buffer_line_height.custom = 1.55;

      tab_size = 4;
      icon_theme = "Catppuccin Macchiato";
      theme = "Catppuccin Macchiato";

      ui_font_family = "Inter";
      buffer_font_family = "JetBrainsMono Nerd Font";
    };
  };

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

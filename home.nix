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

  qt = {
    enable = true;

    platformTheme.name = "qtct";
    style = {
      package = with pkgs; [ darkly-qt5 darkly ];
    };

    qt5ctSettings = {
      Appearance = {
        color_scheme_path = "/home/angel/.config/qt5ct/colors/catppuccin-macchiato-mauve.conf";
        style = "Darkly";
        custom_palette = true;
      };
      Fonts = {
        fixed = "\"JetBrainsMono Nerd Font,10,-1,5,50,0,0,0,0,0,Regular\"";
        general = "\"Inter,10,-1,5,50,0,0,0,0,0,Regular\"";
      };
    };

    qt6ctSettings = {
      Appearance = {
        color_scheme_path = "/home/angel/.config/qt6ct/colors/catppuccin-macchiato-mauve.conf";
        style = "Darkly";
        custom_palette = true;
      };
      Fonts = {
        fixed = "\"JetBrainsMono Nerd Font,10,-1,5,50,0,0,0,0,0,Regular\"";
        general = "\"Inter,10,-1,5,50,0,0,0,0,0,Regular\"";
      };
    };
  };

  xdg.configFile."qt5ct/colors".source = "${pkgs.catppuccin-qt5ct}/share/qt5ct/colors";
  xdg.configFile."qt6ct/colors".source = "${pkgs.catppuccin-qt5ct}/share/qt6ct/colors";

  # User/Home settings
  programs.home-manager.enable = true;
  home.username = "angel";
  home.homeDirectory = "/home/angel";
  home.shell.enableFishIntegration = true;
  home.stateVersion = "25.11"; # This should match what is in configuration.nix's system.stateVersion.

  # Packages installed in the user profile (overrides system profile).
  home.packages = with pkgs; [

    kdePackages.partitionmanager # For managing disks and partitions.
    obs-studio # For recording.
    seahorse # Manage the keyring with a GUI.
    neovim # For editing files in the terminal.
    ente-auth # 2FA

    # Games
    steam
    prismlauncher # Minecraft launcher.

    # Development
    termius # SSH client with GUI
    python3
    bun

    # Fonts
    nerd-fonts.jetbrains-mono
    inter

    # Some Microsoft fonts.
    corefonts
    vista-fonts
  ];

  # WM and interface settings
  xdg.configFile."niri/config.kdl".source = ./niri.kdl; # TODO: Move Noctalia settings to Nix language (using a Niri flake)

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

  programs.ghostty = {
    enable = true;
    
    settings = {
      theme = "Catppuccin Macchiato";
      custom-shader = "/etc/nixos/cursor_warp.glsl";
      font-family = "JetBrainsMono Nerd Font";
      adjust-cursor-thickness = 3;
      quit-after-last-window-closed = false;
    };
  };

  programs.starship = {
    enable = true;
    presets = ["nerd-font-symbols"];

    settings = {
      character = {
        format = "$symbol ";
        success_symbol = "[->](bold green)";
        error_symbol = "[ ->](bold red)";
      };

      palette = "catppuccin-macchiato";
      palettes.catppuccin-macchiato = {
        rosewater = "#f4dbd6";
        flamingo = "#f0c6c6";
        pink = "#f5bde6";
        mauve = "#c6a0f6";
        red = "#ed8796";
        maroon = "#ee99a0";
        peach = "#f5a97f";
        yellow = "#eed49f";
        green = "#a6da95";
        teal = "#8bd5ca";
        sky = "#91d7e3";
        sapphire = "#7dc4e4";
        blue = "#8aadf4";
        lavender = "#b7bdf8";
        text = "#cad3f5";
        subtext1 = "#b8c0e0";
        subtext0 = "#a5adcb";
        overlay2 = "#939ab7";
        overlay1 = "#8087a2";
        overlay0 = "#6e738d";
        surface2 = "#5b6078";
        surface1 = "#494d64";
        surface0 = "#363a4f";
        base = "#24273a";
        mantle = "#1e2030";
        crust = "#181926";
      };
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

  xdg.configFile."zen/default/chrome/userChrome.css".source = ./zen-browser/userChrome.css;
  xdg.configFile."zen/default/chrome/userContent.css".source = ./zen-browser/userContent.css;
  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    policies = let
      mkExtensionSettings = builtins.mapAttrs (_: pluginId: {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
        installation_mode = "force_installed";
      });
    in {
      ExtensionSettings = mkExtensionSettings {
        # "extension-id" = "extension-name";
        # get the extension-id using the get-extension-id.sh script. shell alias: get-extension-id
        # get the extension-name from the extension link https://addons.mozilla.org/en-US/firefox/addon/<extension-name>/
        "uBlock0@raymondhill.net" = "ublock-origin";
        "sponsorblock" = "sponsorBlocker@ajay.app";
        "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = "return-youtube-dislikes";
        "addon@darkreader.org" = "darkreader";
        "{bbb880ce-43c9-47ae-b746-c3e0096c5b76}" = "catppuccin-web-file-icons";
        "firefox-extension@steamdb.info" = "steam-database";
      };
    };

    profiles.default = {
      isDefault = true;
      settings = {
        "zen.view.compact.enable-at-startup" = true;
        "zen.view.compact.hide-toolbar" = true;
        "zen.view.use-single-toolbar" = false;
        "zen.welcome-screen.seen" = true;
        "zen.workspaces.continue-where-left-off" = true;
        "zen.tabs.show-newtab-vertical" = false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };

      spaces = {
        "Personal" = {
          id = "c6de089c-410d-4206-961d-ab11f988d40a";
          position = 1000;
          icon = "🏠";
        };
      };

      pins = {
        "Email" = {
          id = "9d8a8f91-7e29-4688-ae2e-da4e49d4a179";
          url = "https://mail.google.com";
          position = 101;
          isEssential = true;
        };
        "GitHub" = {
          id = "48e8a119-5a14-4826-9545-91c8e8dd3bf6";
          url = "https://github.com/";
          position = 102;
          isEssential = true;
        };
        "Calendar" = {
          id = "d85a9026-1458-4db6-b115-346746bcc692";
          url = "https://calendar.google.com/";
          position = 103;
          isEssential = true;
        };
        "WhatsApp" = {
          id = "f8dd784e-11d7-430a-8f57-7b05ecdb4c77";
          url = "https://web.whatsapp.com/";
          position = 104;
          isEssential = true;
        };
      };
    };
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

  xdg.configFile."fish/themes".source = ./fish/themes;
  programs.fish = {
    enable = true;
    shellAliases = {
      nixos-rebuild-switch = "sudo nixos-rebuild switch --flake /etc/nixos#ichigo";
      nixos-rebuild-boot = "sudo nixos-rebuild boot --flake /etc/nixos#ichigo";
      get-extension-id = "${pkgs.bash}/bin/bash ${./zen-browser/get-extension-id.sh}";
    };
    shellInit = builtins.readFile ./fish/config.fish;
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
        "editor.fontFamily" = "'JetBrainsMono Nerd Font', monospace";
        "editor.fontLigatures" = true;
        "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font', monospace";
        "terminal.integrated.fontLigatures.enabled" = true;
      };
    };
  };
}

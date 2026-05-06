{
  pkgs,
  ...
}:

{
  imports = [
    ./programs
  ];

  # User/Home settings
  programs.home-manager.enable = true;
  home.username = "angel";
  home.homeDirectory = "/home/angel";
  home.shell.enableFishIntegration = true;
  home.stateVersion = "25.11"; # This should match what is in configuration.nix's system.stateVersion.
  home.file.".face".source = ./assets/profile-icon.png;

  # Clipboard manager.
  services.wl-clip-persist.enable = true;
  services.cliphist.enable = true;

  # Packages installed in the user profile (overrides system profile).
  home.packages = with pkgs; [
    wl-clipboard # For clipboard management.
    kdePackages.partitionmanager # For managing disks and partitions.
    obs-studio # For recording.
    seahorse # Manage the keyring with a GUI.
    neovim # For editing files in the terminal.
    ente-auth # 2FA
    onlyoffice-desktopeditors # Office suite

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

  # QT theming and settings.
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
}

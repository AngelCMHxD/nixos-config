{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./programs
    inputs.catppuccin.homeModules.catppuccin
  ];

  # User/Home settings
  programs.home-manager.enable = true;
  home.username = "angel";
  home.homeDirectory = "/home/angel";
  home.shell.enableFishIntegration = true;
  home.stateVersion = "25.11"; # This should match what is in configuration.nix's system.stateVersion.
  home.file.".face".source = ./assets/profile-icon.png;
  catppuccin.accent = "mauve";
  catppuccin.flavor = "macchiato";

  # Clipboard manager.
  services.wl-clip-persist.enable = true;
  services.cliphist.enable = true;

  # Catppuccin themes for some apps
  catppuccin.bat.enable = true;
  catppuccin.lsd.enable = true;
  catppuccin.btop.enable = true;

  # Packages installed in the user profile (overrides system profile).
  home.packages = with pkgs; [
    wl-clipboard # For clipboard management.
    kdePackages.partitionmanager # For managing disks and partitions.
    obs-studio # For recording.
    seahorse # Manage the keyring with a GUI.
    neovim # For editing files in the terminal.
    ente-auth # 2FA
    onlyoffice-desktopeditors # Office suite
    nautilus # File manager
    pwvucontrol # Audio control

    # Games
    steam
    gamescope

    # Development
    termius # SSH client with GUI
    python3
    bun
    usbutils # For lsusb, etc.
    bat # Replacement for cat with syntax highlighting.
    lsd # Replacement for ls with icons and more features.
    btop # process viewer

    # Fonts
    nerd-fonts.jetbrains-mono
    inter

    # Some Microsoft fonts.
    corefonts
    vista-fonts
    google-fonts
  ];

  # Font settings
  fonts.fontconfig = {
    enable = true;

    defaultFonts = {
      monospace = [ "JetBrainsMono Nerd Font" ];
      sansSerif = [ "Poppins" ];
      serif = [ "Noto Serif" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  # GTK theming.
  gtk = {
    enable = true;
    theme = {
      name = "Colloid-Purple-Dark-Catppuccin";
      package = pkgs.colloid-gtk-theme.override {
        themeVariants = [ "purple" ];
        colorVariants = [ "dark" ];
        sizeVariants = [ "standard" ];
        tweaks = [ "catppuccin" ];
      };
    };
    iconTheme = {
      name = "Colloid-Purple-Catppuccin-Dark";
      package = pkgs.colloid-icon-theme.override {
        schemeVariants = [ "catppuccin" ];
        colorVariants = [ "purple" ];
      };
    };
  };

  # QT theming and settings.
  catppuccin.qt5ct.enable = true;
  qt = {
    enable = true;

    platformTheme.name = "qtct";
    style = {
      package = with pkgs; [ darkly-qt5 darkly ];
    };

    qt5ctSettings = {
      Appearance = {
        style = "Darkly";
      };
      Fonts = {
        fixed = "\"JetBrainsMono Nerd Font,10,-1,5,50,0,0,0,0,0,Regular\"";
        general = "\"Inter,10,-1,5,50,0,0,0,0,0,Regular\"";
      };
    };

    qt6ctSettings = {
      Appearance = {
        style = "Darkly";
      };
      Fonts = {
        fixed = "\"JetBrainsMono Nerd Font,10,-1,5,50,0,0,0,0,0,Regular\"";
        general = "\"Inter,10,-1,5,50,0,0,0,0,0,Regular\"";
      };
    };
  };
}

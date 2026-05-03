# Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, inputs, pkgs, ... }:
let
  pkgsUnstable = import inputs."nixpkgs-unstable" {
    system = pkgs.stdenv.hostPlatform.system;
    config = config.nixpkgs.config;
  };
in
{
  imports =
    [
      ./ichigo-hardware.nix
    ];

  boot.initrd.systemd.enable = true;
  boot.initrd.systemd.tpm2.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the Limine boot loader.
  boot.loader.limine = {
    enable = true;
    maxGenerations = 5;
    
    style = {
      wallpapers = []; # Disable NixOS background.

      # Catppuccin Theme. Taken from https://github.com/catppuccin/limine/blob/main/themes/catppuccin-macchiato.conf
      graphicalTerminal = {
        palette = "24273a;ed8796;a6da95;eed49f;8aadf4;f5bde6;8bd5ca;cad3f5";
        brightPalette = "5b6078;ed8796;a6da95;eed49f;8aadf4;f5bde6;8bd5ca;cad3f5";
        background = "24273a";
        foreground = "cad3f5";
        brightBackground = "5b6078";
        brightForeground = "cad3f5";
      };
    };

    secureBoot = { # Auto setup for secure boot.
      enable = true;
      autoGenerateKeys = true;
      autoEnrollKeys = {
        enable = true;
        extraArgs = [
          "--microsoft"
          "--firmware-builtin"
        ];
      };
    };

    # Windows dual-boot
    extraEntries = ''
        /Windows
          protocol: efi
          path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
      '';
  };
      
  boot.loader.efi.canTouchEfiVariables = true;

  services.envfs.enable = true;
  programs.nix-ld.enable = true;

  # Use testing kernel from nixpkgs-unstable.
  boot.kernelPackages = pkgsUnstable.linuxPackages_testing;

  networking.hostName = "ichigo"; # Define your hostname.

  # Configure hardware settings.
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;

  # Power management settings.
  services.tlp.enable = false;
  services.tuned.enable = true;
  services.tuned.ppdSupport = true;
  services.upower.enable = true;


  # Set your time zone.
  time.timeZone = "America/Bogota";

  # Disable the X11 windowing system. (let niri handle it using xwayland-satellite)
  services.xserver.enable = false;

  # Use niri
  services.displayManager.plasma-login-manager.enable = true;
  programs.niri.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Use pipewire for audio.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  programs.fish.enable = true;
  users.users.angel = {
    isNormalUser = true;
    shell = pkgs.fish; # Set the default shell to Fish.
    home = "/home/angel";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    # Packages on home.nix
  };

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    xwayland-satellite # For running X11 applications in niri.
    sbctl # For managing secure boot keys.
    nil # Nix LSP
    nixd # Nix LSP

    # Misc utilities
    git
    curl
  ];

  services.gnome.gcr-ssh-agent.enable = false;
  programs.ssh.startAgent = true;
  services.dbus.enable = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;


  # Do NOT change this option unless you know exactly what you are doing.
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # This should match what is in home.nix's home.stateVersion.

}

# Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ inputs, pkgs, ... }:
{
    imports = [
        ./ichigo-hardware.nix
        inputs.noctalia-greeter.nixosModules.default
        inputs.catppuccin.nixosModules.catppuccin
        inputs.niri.nixosModules.niri
    ];

    systemd.user.services.niri-flake-polkit.enable = false;

    nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
        accept-flake-config = true;
    };

    system.activationScripts.diff = {
        supportsDryActivation = true;
        text = ''
            if [ -e /run/current-system ]; then
                echo
                echo -e "\033[0;32mPackage diffs:\033[0m"
                ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff /run/current-system "$systemConfig"
                echo
            fi
        '';
    };

    catppuccin.enable = true;
    catppuccin.sources = inputs.catppuccin.packages.${pkgs.stdenv.hostPlatform.system}.overrideScope (_: _: {
        whiskers = pkgs.catppuccin-whiskers;
    });
    catppuccin.autoEnable = false;
    catppuccin.tty.enable = true; # Enable Catppuccin TTY theme.

    # Use systemd for the init system and enable TPM2 support for auto-unlock of the LUKS volume.
    boot.initrd.systemd.enable = true;
    boot.initrd.systemd.tpm2.enable = true;

    # Use the Limine boot loader.
    catppuccin.limine.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.limine = {
        enable = true;
        maxGenerations = 5;

        style = {
        # Disable NixOS background.
        wallpapers = [];
        };

        # Auto setup for secure boot.
        secureBoot = {
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

    # Enable envfs and nix-ld for better support of non-Nix apps.
    services.envfs.enable = true;
    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
        libsecret
        glib
    ];

    environment.sessionVariables = {
        LD_LIBRARY_PATH = [ "/run/current-system/sw/share/nix-ld/lib" ];
    };

    # Latest kernel
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # Define hostname.
    networking.hostName = "ichigo";

    # Configure hardware settings.
    networking.networkmanager.enable = true;
    hardware.bluetooth.enable = true;
    hardware.steam-hardware.enable = true;

    # Games
    programs.gamescope.enable = true;
    programs.gamemode.enable = true;

    # Power management settings.
    services.tlp.enable = false;
    services.tuned.enable = true;
    services.tuned.ppdSupport = true;
    services.upower.enable = true;

    # Set the time zone.
    time.timeZone = "America/Bogota";

    # WM and display settings.
    services.logind.settings.Login.HandlePowerKey = "ignore"; # Disable power key, handle it on the WM.
    services.xserver.enable = false; # Niri uses xwayland-satellite, so no need for xserver.
    programs.niri.enable = true;
    programs.noctalia-greeter = {
        enable = true;
        package = inputs.noctalia-greeter.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };

    programs.appimage = {
        enable = true;
        binfmt = true;
    };

    # Use pipewire for audio.
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
    };

    # Enable CUPS to print documents.
    # services.printing.enable = true;

    # Setup the user account.
    programs.fish.enable = true;
    users.users.angel = {
        isNormalUser = true;
        shell = pkgs.fish; # Set the default shell to Fish.
        home = "/home/angel";
        extraGroups = [ "wheel" "networkmanager" "input" ];
        # Packages on home.nix
    };

    # List of packages installed in system profile.
    # Use https://search.nixos.org/ to find more packages (and options).
    environment.systemPackages = with pkgs; [
        xwayland-satellite # For running X11 applications on Niri.
        devenv
        dconf
        xdg-desktop-portal
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
        davinci-resolve

        sbctl # For managing secure boot keys.
        nil # Nix LSP
        nixd # Nix LSP

        # Misc utilities
        git
        curl
        wget
        jq
        unzip
        psmisc
    ];

    # Flatpak support.
    services.flatpak.enable = true;

    # SSH settings.
    programs.ssh.startAgent = false;
    services.gnome.gcr-ssh-agent.enable = true;
    environment.sessionVariables.SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/gcr/ssh";
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.greetd.enableGnomeKeyring = true;
    services.dbus.enable = true;
    programs.gnupg.agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-gnome3;
    };

    # For palera1n: https://github.com/palera1n/palera1n
    services.usbmuxd.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # KDE Connect ports
    networking.firewall = rec {
        allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
        allowedUDPPortRanges = allowedTCPPortRanges;
    };
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;


    # Do NOT change this option unless you know exactly what you are doing.
    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "25.11"; # This should match what is in home.nix's home.stateVersion.
}

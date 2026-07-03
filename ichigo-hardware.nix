{ config, lib, modulesPath, ... }:

{
    imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];

    hardware.opentabletdriver.enable = true;
    hardware.uinput.enable = true;

    boot.kernelModules = [ "kvm-amd" "uinput"  ];
    boot.extraModulePackages = [ ];

    boot.initrd.luks.devices."root" = {
        device = "/dev/disk/by-partlabel/crypt-root";
        crypttabExtraOpts = [ "tpm2-device=auto" ];

        # Kernel parameters for SSDs.
        # Info from https://wiki.archlinux.org/title/Dm-crypt/Specialties
        # Options found at https://nixos.org/manual/nixos/stable/options#opt-boot.initrd.luks.devices
        bypassWorkqueues = true; # Improves performance
        allowDiscards = true; # Allows TRIM, improves lifespan
    };

    fileSystems."/" = {
        device = "/dev/mapper/root";
        fsType = "btrfs";
        options = [ "compress-force=zstd" ];
    };

    fileSystems."/boot" = {
        device = "/dev/disk/by-partlabel/boot";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
    };

    swapDevices = [
        {
            device = "/var/lib/swapfile";
            size = 48*1024;
        }
    ];

    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

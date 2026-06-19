{
    inputs = {
        # Use `nix flake update` to update the flake to the latest revision of the chosen release channel.
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

        nixcord.url = "github:FlameFlag/nixcord/dev";
        spicetify-nix.url = "github:Gerg-L/spicetify-nix";
        nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
        catppuccin.url = "github:catppuccin/nix";
        niri.url = "github:epireyn/niri-flake";

        vicinae.url = "github:vicinaehq/vicinae";
        vicinae-extensions = {
            url = "github:vicinaehq/extensions";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        noctalia.url = "github:noctalia-dev/noctalia";
        noctalia-greeter = {
            url = "github:noctalia-dev/noctalia-greeter";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nix4vscode = {
            url = "github:nix-community/nix4vscode";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake/beta";
            inputs = {
                nixpkgs.follows = "nixpkgs";
                home-manager.follows = "home-manager";
            };
        };
    };

    nixConfig = {
        extra-substituters = [
            "https://noctalia.cachix.org"
            "https://vicinae.cachix.org"
            "https://niri-epireyn.cachix.org"
        ];
        extra-trusted-public-keys = [
            "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
            "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
            "niri-epireyn.cachix.org-1:tlVyFN7CtsDT+ZcLPS+ekFWeT1X6X4OqvWqbBMyIzFA="
        ];
    };

    outputs = inputs@{ self, nixpkgs, home-manager, catppuccin, ... }: {
        nixosConfigurations.ichigo = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            modules = [
                {
                    nixpkgs.config.allowUnfree = true;
                    nixpkgs.overlays = [ inputs.nix4vscode.overlays.default inputs.niri.overlays.niri ];
                }
                inputs.vicinae.nixosModules.default
                ./configuration.nix
                home-manager.nixosModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.extraSpecialArgs = { inherit inputs; };
                    home-manager.backupFileExtension = "hm-backup";
                    home-manager.users.angel = ./home.nix;
                }
            ];
        };
    };
}

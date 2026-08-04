{ inputs, pkgs, ... }:
{
    imports = [
        inputs.nixcord.homeModules.nixcord
    ];

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
                    allowChangingDangerousSettings = true;

                    autoCompleteQuestTypes = {
                        PLAY_ON_DESKTOP = true;
                        PLAY_ON_XBOX = true;
                        PLAY_ON_PLAYSTATION = true;
                        PLAY_ACTIVITY = true;
                        WATCH_VIDEO = true;
                        ACHIEVEMENT_IN_ACTIVITY = true;
                    };
                };

                loadingQuotes = {
                    enable = true;
                    additionalQuotes = builtins.concatStringsSep "|" [
                        ":P"
                        ";D"
                        "Loading... maybe?"
                    ];
                };

                voiceRejoin = {
                    enable = true;
                    rejoinTimeout = 60.0;
                };

                # Youtube patches
                fixYoutubeEmbeds.enable = true;
                youtubeAdblock.enable = true;
                dearrow.enable = true;

                # Spotify
                fixSpotifyEmbeds.enable = true;
                spotifyCrack.enable = true;

                betterInvites.enable = true;
                betterGifPicker.enable = true;
                bypassPinPrompt.enable = true;
                clearUrls.enable = true;
                fixImagesQuality.enable = true;
                ghosted.enable = true;
                mentionAvatars.enable = true;
                homeTyping.enable = true;
                micLoopbackTester.enable = true;
                noF1.enable = true;
                noOnboardingDelay.enable = true;
                onePingPerDm.enable = true;
                roleColorEverywhere.enable = true;
                typingIndicator.enable = true;
                consoleJanitor.enable = true;
                experiments.enable = true;
                noDevtoolsWarning.enable = true;
                gameActivityToggle.enable = true;
            };
        };
    };

    # NixOS version of https://github.com/Arcitec/discord-flatpak-rpc-bridge
    # So the native Discord client can communicate with Flatpak apps
    systemd.user.sockets.discord-flatpak-rpc-bridge = {
        Unit = {
            Description = "Discord Native-to-Flatpak RPC Bridge Socket";
        };
        Socket = {
            Priority = 6;
            ListenStream = "%t/app/com.discordapp.Discord/discord-ipc-0";
        };
        Install = {
            WantedBy = [ "sockets.target" ];
        };
    };

    systemd.user.services.discord-flatpak-rpc-bridge = {
        Unit = {
            Description = "Discord Native-to-Flatpak RPC Bridge Service";
            Requires = [ "discord-flatpak-rpc-bridge.socket" ];
            After = [ "discord-flatpak-rpc-bridge.socket" ];
        };
        Service = {
            Type = "notify";
            ExecStart = "${pkgs.systemd}/lib/systemd/systemd-socket-proxyd %t/discord-ipc-0";
            PrivateTmp = true;
            PrivateNetwork = true;
        };
    };
}

{ inputs, ... }:
{
    imports = [
        inputs.zen-browser.homeModules.beta
    ];

    # Manual theming as catppuccin/nix doesn't support the zen-browser flake.
    xdg.configFile."zen/default/chrome/userChrome.css".source = ./userChrome.css;
    xdg.configFile."zen/default/chrome/userContent.css".source = ./userContent.css;
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
                "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}" = "styl-us"; # Can't be reproducible or at least it's really difficult to do so.
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

            spacesForce = true;
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
}

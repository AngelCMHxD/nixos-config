{ inputs, pkgs, ... }:
{
    programs.niri = {
        package = pkgs.niri-unstable;
        settings = {
            hotkey-overlay = {
                skip-at-startup = true;
                hide-not-bound = true;
            };
            prefer-no-csd = true;

            input = {
                touchpad.natural-scroll = true;
                power-key-handling.enable = false;
                keyboard = {
                    xkb.layout = "latam";
                    numlock = true;
                };
            };

            cursor = {
                theme = "Bibata-Modern-Classic";
                size = 20;
            };

            outputs."eDP-1".mode = {
                width = 1920;
                height = 1080;
                refresh = 60.0;
            };

            layout = {
                gaps = 4;

                preset-column-widths = [
                    { proportion = 1. / 3.; }
                    { proportion = 1. / 2.; }
                    { proportion = 2. / 3.; }
                ];

                default-column-width.proportion = 1. / 2.;

                focus-ring.enable = false;
                border = {
                    enable = true;

                    width = 3;

                    active.color = "#c6a0f6";
                    inactive.color = "#6e738d";
                    urgent.color = "#ed8796";
                };
            };

            overview = {
                zoom = 0.25;
                backdrop-color = "#24273a";
            };

            animations = {
                slowdown = 1.5;

                window-open.kind.easing = {
                    duration-ms = 300;
                    curve = "ease-out-expo";
                };

                window-close.kind.easing = {
                    duration-ms = 200;
                    curve = "ease-out-quad";
                };
            };

            blur = {
                passes = 1;
                noise = 0.0;
                offset = 1.0;
            };

            layer-rules = [
                {
                    matches = [{
                        namespace = "^noctalia-backdrop";
                    }];

                    place-within-backdrop = true;
                }
                {
                    matches = [
                        {
                            namespace = "vicinae";
                        }
                        {
                            namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$";
                        }
                    ];
                    background-effect = {
                        blur = true;
                        xray = false;
                    };
                }
            ];

            window-rules = [
                {
                    clip-to-geometry = true;
                    geometry-corner-radius = {
                        bottom-left = 12.0;
                        bottom-right = 12.0;
                        top-left = 12.0;
                        top-right = 12.0;
                    };
                }
                {
                    matches = [{
                        app-id = "steam";
                        title = "^notificationtoasts_\\d+_desktop$";
                    }];

                    default-floating-position = {
                        x = 10;
                        y = 10;
                        relative-to = "bottom-right";
                    };

                    open-focused = false;
                }
                {
                    matches = [
                        {
                            app-id = "discord";
                        }
                        {
                            app-id = "zed";
                        }
                        {
                            app-id = "zen";
                        }
                    ];

                    default-column-width.proportion = 1.0;
                }
                {
                    matches = [{
                        app-id = "vicinae";
                    }];
                    background-effect = {
                        blur = true;
                        xray = false;
                    };
                }
            ];

            spawn-at-startup = [
                { sh = "noctalia -d"; }
                { sh = "vicinae server"; }
            ];

            binds = {
                "Mod+Shift+H".action.show-hotkey-overlay = { };

                # Window and workspace binds
                "Mod+Return" = {
                    action.spawn = "ghostty";
                    hotkey-overlay.title = "Open a Terminal: ghostty";
                };
                "Mod+O" = {
                    action.toggle-overview = {};
                    hotkey-overlay.title = "Toggle Overview";
                    repeat = false;
                };
                "Mod+Backspace" = {
                    action.close-window = {};
                    hotkey-overlay.title = "Close Window";
                    repeat = false;
                };

                "Mod+R" = {
                    action.spawn-sh = "vicinae toggle";
                    hotkey-overlay.title = "Toggle launcher: vicinae";
                    repeat = false;
                };

                "Mod+F".action.maximize-column = {};
                "Mod+Shift+F".action.fullscreen-window = {};
                "Mod+Minus".action.set-column-width = "-10%";
                "Mod+Plus".action.set-column-width = "+10%";
                "Mod+Shift+V".action.toggle-window-floating = {};

                "Mod+Left".action.focus-column-left = {};
                "Mod+Right".action.focus-column-right = {};
                "Mod+Up".action.focus-window-or-workspace-up = {};
                "Mod+Down".action.focus-window-or-workspace-down = {};

                "Mod+Shift+Left".action.move-column-left = {};
                "Mod+Shift+Right".action.move-column-right = {};
                "Mod+Shift+Up".action.move-window-up = {};
                "Mod+Shift+Down".action.move-window-down = {};

                "Mod+U".action.focus-workspace-up = {};
                "Mod+I".action.focus-workspace-down = {};
                "Mod+Shift+U".action.move-workspace-down = {};
                "Mod+Shift+I".action.move-workspace-up = {};

                "Mod+WheelScrollDown" = {
                    action.focus-workspace-down = {};
                    cooldown-ms = 150;
                };
                "Mod+WheelScrollUp" = {
                    action.focus-workspace-up = {};
                    cooldown-ms = 150;
                };

                # Workspace management
                "Mod+1".action.focus-workspace = 1;
                "Mod+2".action.focus-workspace = 2;
                "Mod+3".action.focus-workspace = 3;
                "Mod+4".action.focus-workspace = 4;
                "Mod+5".action.focus-workspace = 5;
                "Mod+6".action.focus-workspace = 6;
                "Mod+7".action.focus-workspace = 7;
                "Mod+8".action.focus-workspace = 8;
                "Mod+9".action.focus-workspace = 9;
                "Mod+Shift+1".action.move-column-to-workspace = 1;
                "Mod+Shift+2".action.move-column-to-workspace = 2;
                "Mod+Shift+3".action.move-column-to-workspace = 3;
                "Mod+Shift+4".action.move-column-to-workspace = 4;
                "Mod+Shift+5".action.move-column-to-workspace = 5;
                "Mod+Shift+6".action.move-column-to-workspace = 6;
                "Mod+Shift+7".action.move-column-to-workspace = 7;
                "Mod+Shift+8".action.move-column-to-workspace = 8;
                "Mod+Shift+9".action.move-column-to-workspace = 9;


                # Audio volume control
                "XF86AudioRaiseVolume" = {
                    action.spawn-sh = "noctalia msg volume-up";
                    allow-when-locked = true;
                };
                "XF86AudioLowerVolume" = {
                    action.spawn-sh = "noctalia msg volume-down";
                    allow-when-locked = true;
                };
                "XF86AudioMute" = {
                    action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
                    allow-when-locked = true;
                };
                "XF86AudioMicMute" = {
                    action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
                    allow-when-locked = true;
                };

                # Media controls
                "XF86AudioPlay" = {
                    action.spawn-sh = "playerctl play-pause";
                    allow-when-locked = true;
                };
                "XF86AudioStop" = {
                    action.spawn-sh = "playerctl stop";
                    allow-when-locked = true;
                };
                "XF86AudioPrev" = {
                    action.spawn-sh = "playerctl previous";
                    allow-when-locked = true;
                };
                "XF86AudioNext" = {
                    action.spawn-sh = "playerctl next";
                    allow-when-locked = true;
                };


                # Noctalia binds
                "Mod+L" = {
                    action.spawn-sh = "noctalia msg screen-lock";
                    hotkey-overlay.title = "Lock: noctalia";
                };
                "Mod+Ctrl+Shift+S" = {
                    action.spawn-sh = "noctalia msg settings-toggle";
                    hotkey-overlay.title = "Open Settings: noctalia";
                };
                "Mod+Ctrl+Shift+W" = {
                    action.spawn-sh = "noctalia msg panel-toggle wallpaper";
                    hotkey-overlay.title = "Open Wallpaper Panel: noctalia";
                };
                "Mod+V" = {
                    action.spawn-sh = "noctalia msg panel-toggle clipboard";
                    hotkey-overlay.title = "Open Clipboard Panel: noctalia";
                };
                "Mod+Ctrl+Shift+N" = {
                    action.spawn-sh = "killall -w noctalia ; noctalia -d";
                    hotkey-overlay.title = "Restart shell: noctalia";
                };
                "XF86PowerOff" = {
                    action.spawn-sh = "noctalia msg panel-toggle session";
                    allow-when-locked = true;
                };
                "XF86MonBrightnessUp" = {
                    action.spawn-sh = "noctalia msg brightness-up";
                    allow-when-locked = true;
                };
                "XF86MonBrightnessDown" = {
                    action.spawn-sh = "noctalia msg brightness-down";
                    allow-when-locked = true;
                };

                # Screenshot binds
                "Print".action.screenshot = {};
                "Ctrl+Print".action.screenshot-screen = {};
                "Alt+Print".action.screenshot-window = {};

                "Mod+Escape" = {
                    action.toggle-keyboard-shortcuts-inhibit = {};
                    allow-inhibiting = false;
                };

                "Ctrl+Alt+Delete".action.quit = {};
                "Mod+Ctrl+Shift+P".action.power-off-monitors = {};
            };
        };
    };
}

{ inputs, pkgs, ... }:
{
    imports = [
        inputs.noctalia.homeModules.default
    ];

    programs.noctalia = {
        enable = true;

        settings = {
            shell = {
                polkit_agent = true;
                password_style = "random";
                avatar_path = "/etc/nixos/assets/profile-icon.png";

                screenshot = {
                    copy_to_clipboard = true;
                    freeze_screen = true;
                };
            };

            notifications.monitors = [ "eDP-1" ];
            osd.monitors = [ "eDP-1" ];

            wallpaper = {
                enabled = true;
                transition_on_startup = true;
                directory = "/etc/nixos/assets/wallpapers";
                default.path = "/etc/nixos/assets/wallpapers/catppuccin.png";

                automation = {
                    enabled = true;
                    interval_minutes = 1;
                };
            };

            theme = {
                builtin = "Catppuccin";
            };

            weather = {
                enabled = true;
                auto_locate = true;
                refresh_minutes = 15;
            };

            idle.behavior = {
                lock = {
                    enabled = true;
                    timeout = 600;
                    command = "noctalia:screen-lock";
                };

                screen-off = {
                    enabled = true;
                    timeout = 600;
                    command = "noctalia:dpms-off";
                    resume_command = "noctalia msg dpms-on";
                };
            };

            widget = {
                clock = {
                    format = "{:%H:%M} - {:%d} {:%b} {:%Y}";
                };
            };

            bar = {
                order = [ "default" ];

                default = {
                    position = "top";
                    enabled = true;
                    monitor."HDMI-A-1" = {
                        match = "HDMI-A-1";
                        enabled = false;
                    };
                    auto_hide = false;
                    reserve_space = true;

                    thickness = 34;
                    background_opacity = 0.8;
                    border = "outline";
                    border_width = 3;
                    shadow = true;
                    contact_shadow = false;
                    panel_overlap = 1;
                    radius = 12;
                    margin_ends = 5;
                    margin_edge = 5;
                    padding = 14;
                    widget_spacing = 8;
                    scale = 1.0;
                    font_weight = "regular";

                    capsule = false;
                    capsule_fill = "surface_variant";
                    capsule_radius = 8.0;
                    capsule_opacity = 1.0;
                    # capsule_border = "outline";

                    start = ["launcher" "wallpaper" "workspaces" ];
                    center = ["clock"];
                    end = ["media" "tray" "notifications" "clipboard" "network" "bluetooth" "volume" "brightness" "battery" "control-center" "session" ];
                };
            };
        };
    };
}

{ ... }:
{
    catppuccin.zed.enable = true;
    catppuccin.zed.icons.enable = true;
    programs.zed-editor = {
        enable = true;

        extensions = [
            "discord-presence"
            "wakatime"
        ];

        userSettings = {
            cli_default_open_behavior = "new_window";
            project_panel = {
                dock = "left";
                sort_mode = "directories_first";
                hide_hidden = false;
                hide_root = false;
                indent_guides.show = "always";

                git_status_indicator = true;
                diagnostic_badges = false;
                bold_folder_labels = true;
                auto_fold_dirs = false;

                indent_size = 15;

                git_status = true;
                folder_icons = true;
                file_icons = true;
                entry_spacing = "standard";
            };

            languages.Python.format_on_save = "off";
            inlay_hints = {};

            lsp = {
                discord_presence = {
                    initialization_options = {
                        details = "Working on a {language:u} file";
                        state = ":P";
                    };
                };
            };

            buffer_line_height.custom = 1.55;

            tab_size = 4;

            ui_font_family = "Poppins";
            buffer_font_family = "JetBrainsMono Nerd Font";
        };
    };
}

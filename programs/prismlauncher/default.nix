{ ... }:
{
    home.file.".local/share/PrismLauncher/themes/Catppuccin-Macchiato".source = ./theme;

    programs.prismlauncher = {
        enable = true;
        settings = {
            ApplicationTheme = "Catppuccin-Macchiato";
        };
    };
}

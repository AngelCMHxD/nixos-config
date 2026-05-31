{ ... }:
{
    catppuccin.ghostty.enable = true;
    programs.ghostty = {
        enable = true;

        settings = {
            custom-shader = "/etc/nixos/programs/ghostty/cursor_warp.glsl";
            font-family = "JetBrainsMono Nerd Font";
            adjust-cursor-thickness = 3;
            quit-after-last-window-closed = false;
        };
    };
}

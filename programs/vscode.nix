{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    profiles.default = {
      extensions = with pkgs.vscode-marketplace; [
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        jnoortheen.nix-ide
        biomejs.biome
        oven.bun-vscode
        icrawl.discord-vscode
        janisdd.vscode-edit-csv
        eamodio.gitlens
        ms-python.python
        ms-python.vscode-pylance
        github.copilot-chat
        shd101wyy.markdown-preview-enhanced
      ];
      
      userSettings = {
        # Theme
        "workbench.colorTheme" = "Catppuccin Macchiato";
        "workbench.iconTheme" = "catppuccin-macchiato";

        # Formatter
        "editor.defaultFormatter" = "biomejs.biome";
        "biome.requireConfiguration" = true;
        "biome.suggestInstallingGlobally" = false;

        # Extensions
        "nix.enableLanguageServer" = true;
        "discord.lowerDetailsEditing" = ":P";
        "discord.lowerDetailsDebugging" = ":P";

        # Text editor
        "editor.formatOnSave" = true;
        "editor.cursorSmoothCaretAnimation" = true;
        "editor.smoothScrolling" = true;
        "editor.fontFamily" = "'JetBrainsMono Nerd Font', monospace";
        "editor.fontLigatures" = true;

        # Terminal
        "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font', monospace";
        "terminal.integrated.fontLigatures.enabled" = true;
        "terminal.integrated.cursorStyle" = "line";
        "terminal.integrated.cursorWidth" = 2;
        "terminal.integrated.cursorBlinking" = true;
      };
    };
  };
}

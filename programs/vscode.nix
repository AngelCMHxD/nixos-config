{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    profiles.default = {
      extensions = pkgs.nix4vscode.forVscode [
        # Theming
        "catppuccin.catppuccin-vsc"
        "catppuccin.catppuccin-vsc-icons"

        # LSP and formatting
        "jnoortheen.nix-ide"
        "biomejs.biome"
        "oven.bun-vscode"
        "ms-python.python"
        "ms-python.vscode-pylance"

        # Misc
        "eamodio.gitlens"
        "janisdd.vscode-edit-csv"
        "icrawl.discord-vscode"
        "github.copilot-chat"
        "shd101wyy.markdown-preview-enhanced"
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
        "editor.cursorSmoothCaretAnimation" = "on";
        "editor.smoothScrolling" = true;
        "editor.fontFamily" = "'JetBrainsMono Nerd Font', monospace";
        "editor.fontLigatures" = true;

        # Terminal
        "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font', monospace";
        "terminal.integrated.fontLigatures.enabled" = true;
        "terminal.integrated.cursorStyle" = "line";
        "terminal.integrated.cursorWidth" = 2;
        "terminal.integrated.cursorBlinking" = true;

        # JSON Schemas
        "json.schemaDownload.trustedDomains" = {
          # Default trusted domains from the json-language-features extension
          # Available at https://github.com/microsoft/vscode/blob/main/extensions/json-language-features/package.json
          "https://schemastore.azurewebsites.net/" = true;
          "https://raw.githubusercontent.com/microsoft/vscode/" = true;
          "https://raw.githubusercontent.com/devcontainers/spec/" = true;
          "https://www.schemastore.org/" = true;
          "https://json.schemastore.org/" = true;
          "https://json-schema.org/" = true;
          "https://developer.microsoft.com/json-schemas/" = true;

          # Additional trusted domains
          "https://biomejs.dev" = true;
        };
      };
    };
  };
}

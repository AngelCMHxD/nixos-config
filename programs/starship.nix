{ ... }:
{
  catppuccin.starship.enable = true;
  programs.starship = {
    enable = true;
    presets = ["nerd-font-symbols"];

    settings = {
      character = {
        format = "$symbol ";
        success_symbol = "[->](bold green)";
        error_symbol = "[ ->](bold red)";
      };
    };
  };

}
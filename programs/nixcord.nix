{ inputs, ... }:
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

        questify.enable = true;

        # Youtube patches
        fixYoutubeEmbeds.enable = true;
        youtubeAdblock.enable = true;
        dearrow.enable = true;

        # Spotify
        fixSpotifyEmbeds.enable = true;
        spotifyCrack.enable = true;
        spotifyActivityToggle.enable = true;

        consoleJanitor.enable = true;
        experiments.enable = true;
        noDevtoolsWarning.enable = true;
        gameActivityToggle.enable = true;
      };
    };
  };
}
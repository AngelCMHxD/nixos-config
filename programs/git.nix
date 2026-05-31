{ ... }:
{
    programs.git = {
        enable = true;
        signing = {
            key = "~/.ssh/id_ed25519.pub";
            signByDefault = true;
        };
        settings = {
            init.defaultBranch = "main";
            gpg.format = "ssh";
            user = {
                name = "Angel";
                email = "57822483+AngelCMHxD@users.noreply.github.com";
            };
        };
    };
}

{ lib, ... }:

let
    dirContents = builtins.readDir ./.;

    nixFiles = builtins.filter
        (name: dirContents.${name} == "regular" && name != "default.nix" && lib.strings.hasSuffix ".nix" name)
        (builtins.attrNames dirContents);

    dirs = builtins.filter
        (name: dirContents.${name} == "directory" && builtins.pathExists (./. + "/${name}/default.nix"))
        (builtins.attrNames dirContents);
in
{
    imports =
        (map (file: ./${file}) nixFiles) ++
        (map (dir: ./${dir}) dirs); # Nix uses the default.nix file in each dir
}

{ flakePath }:
let
  Flake =
    if builtins.pathExists flakePath then
      (import
        (fetchTarball {
          url = "https://github.com/edolstra/flake-compat/archive/0f9255e01c2351cc7d116c072cb317785dd33b33.tar.gz";
          sha256 = "0p1qsrb4hvy054wvnpihhwvxc7b34pjpx07h6a9cw201flyb6lj6";
        })
        { src = toString flakePath; }
      ).defaultNix
    else
      { };

  Channels = Flake.pkgs.${builtins.currentSystem} or <nixpkgs>;

  LoadFlake = builtins.getFlake (toString flakePath);
in
{
  inherit Channels Flake LoadFlake;
}

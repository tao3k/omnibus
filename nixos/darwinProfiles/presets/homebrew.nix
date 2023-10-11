{
  omnibus,
  pkgs,
  lib,
}:
let
  inherit (pkgs.stdenv.hostPlatform) isAarch64;
  brewPrefix = if isAarch64 then "/opt/homebrew" else "/usr/local";
in
{
  imports = [ omnibus.darwinModules.homebrew ];

  # credit: https://github.com/montchr/dotfield/blob/dd5e577d91b1af7f13909f5dc4343717a718ff02/darwin/profiles/core/default.nix
  homebrew = {
    enable = true;
    # onActivation.cleanup = "zap";
    onActivation.upgrade = true;
    # Use the nix-darwin brewfile when invoking `brew bundle` imperatively.
    global.brewfile = true;
    global.lockfiles = false;
    __profiles__ = {
      readers = true;
      shell = true;
      casks.removePackagesFromProfiles = [ ];
      brews.removePackagesFromProfiles = [ ];
    };
  };
  # <https://github.com/LnL7/nix-darwin/issues/596>
  #
  # $ brew shellenv
  # export HOMEBREW_PREFIX="/opt/homebrew";
  # export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
  # export HOMEBREW_REPOSITORY="/opt/homebrew";
  # export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
  # export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
  # export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
  environment.systemPath = lib.mkBefore [
    "${brewPrefix}/bin"
    "${brewPrefix}/sbin"
  ];
  environment.variables = {
    HOMEBREW_PREFIX = brewPrefix;
    HOMEBREW_CELLAR = "${brewPrefix}/Cellar";
    HOMEBREW_REPOSITORY = brewPrefix;
    MANPATH = "${brewPrefix}/share/man:$MANPATH";
    INFOPATH = "${brewPrefix}/share/info:$INFOPATH";
  };
}

{
  omnibus,
  pkgs,
  lib,
  config,
}:
let
  inherit (pkgs.stdenv.hostPlatform) isAarch64;
  cfg = config.omnibus.bootstrap;
in
{
  imports = [ omnibus.darwinModules.bootstrap ];
  config = {
    omnibus.bootstrap.PATH = lib.mkBefore [
      "/run/current-system/sw/bin"
      "/run/current-system/etc/profiles/per-user/$USER/bin"
      "/opt/homebrew/bin"
      "/bin/"
      "/usr/bin"
      "/usr/bin/sbin"
      "/usr/local/bin"
      "/usr/sbin"
      "/sbin"
    ];
    environment.systemPath = [ ];
    environment.variables.PATH = cfg.PATH;
  };
}

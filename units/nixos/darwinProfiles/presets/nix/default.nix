{
  lib,
  pkgs,
  loadSubmodule,
}:
let
  l = lib // builtins;
  inherit (pkgs.stdenv.hostPlatform) isAarch64;
in
{
  imports = [ (loadSubmodule ./optimise.nix) ];
  nix = {
    package = pkgs.nixUnstable;
    configureBuildUsers = true;
    settings = {
      # Administrative users on Darwin systems are part of the admin group.
      trusted-users = [ "@admin" ];
      extra-platforms = l.mkIf isAarch64 [
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      auto-optimise-store = false;
      experimental-features = [
        "nix-command"
        "flakes"
        "recursive-nix"
      ];
      sandbox = false;
      # https://github.com/NixOS/nix/issues/7273
    };
    extraOptions = ''
      # https://plutus-community.readthedocs.io/en/latest/#Environment/Build/Mac_M1/
      extra-sandbox-paths = /System/Library/Frameworks /System/Library/PrivateFrameworks /usr/lib /private/tmp /private/var/tmp /usr/bin/env
    '';
  };
  services.nix-daemon.enable = true;
  # Recreate /run/current-system symlink after boot
  # services.activate-system.enable = true;
}

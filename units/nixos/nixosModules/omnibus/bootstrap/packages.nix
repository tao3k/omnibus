{
  config,
  lib,
  pkgs,
  omnibus,
}:
let
  cfg = config.omnibus.bootstrap;
in
{
  config =
    with lib;
    mkMerge [
      (mkIf (cfg.minimal || cfg.default) {
        environment.systemPackages = with pkgs; [
          pciutils
          openssl
          wget
          curl
          gnumake
        ];
      })
      (mkIf cfg.default {
        environment.systemPackages = with pkgs; [
          unzip
          gzip
          clang
          nixpkgs-fmt
          pkg-config
          nrepl
          ripgrep
        ];
      })
    ];
}

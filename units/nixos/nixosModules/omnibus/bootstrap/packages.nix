# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

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
          cmake
          coreutils
        ];
      })
      (mkIf cfg.default {
        environment.systemPackages = with pkgs; [
          unzip
          gzip
          clang
          nixpkgs-fmt
          pkg-config
          (pkgs.writeShellScriptBin "nrepl" ''
            export PATH=${pkgs.coreutils}/bin:${pkgs.nixUnstable}/bin:$PATH
            if [ -z "$1" ]; then
               nix repl --argstr host "$HOST" --argstr flakePath "$PRJ_ROOT" ${./nrepl.nix}
             else
               nix repl --argstr host "$HOST" --argstr flakePath $(readlink -f $1 | sed 's|/flake.nix||') ${./nrepl.nix}
             fi
          '')
          ripgrep
        ];
      })
    ];
}

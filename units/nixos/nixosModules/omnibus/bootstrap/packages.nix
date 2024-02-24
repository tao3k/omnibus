# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
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
          ripgrep
        ];
      })
    ];
}

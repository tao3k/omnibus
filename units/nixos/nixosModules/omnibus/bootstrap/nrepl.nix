# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{flakePath}:
let
  Flake =
    if builtins.pathExists flakePath then
      (import (
        (fetchTarball {
          url = "https://github.com/divnix/call-flake/archive/088f8589c7f3ee59bea1858a89f5125d284c3c4a.tar.gz";
          sha256 = "";
        })
        + "/flake.nix"
      )).outputs
        {}
        flakePath
    else
      {};

  Channels = Flake.pkgs.${builtins.currentSystem} or <nixpkgs>;

  LoadFlake = builtins.getFlake (toString flakePath);
in
{
  inherit Channels Flake LoadFlake;
}

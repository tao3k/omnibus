# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ omnibus }:
let
  inherit (omnibus.lib.omnibus) inputsToPaths;
in
{
  inputsToPaths = inputsToPaths {
    b = {
      inputs = {
        d = {
          outPath = "/nix/store/w065s95yy5k456kwa1h6bg9mc46gy89n-tracing-log-0.2.0";
        };
        f = {
          outPath = "<PATH-b.f>";
        };
      };
      outPath = "<PATH-b>";
    };
    a = {
      inputs = {
        b = {
          outPath = "<PATH-a.b>";
        };
        c = {
          outPath = "<PATH-a.c>";
        };
      };
      outPath = "/nix/store/w065s95yy5k456kwa1h6bg9mc46gy89n-tracing-log-0.3.0";
    };
  };
}

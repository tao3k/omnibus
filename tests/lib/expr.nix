# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ omnibus }:
let
  inherit (omnibus.lib) inputsToPaths;
in
{
  inputsToPaths = inputsToPaths {
    b = {
      inputs = {
        d = {
          outPath = "<PATH-b.d>";
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
      outPath = "<PATH-a>";
    };
  };
}

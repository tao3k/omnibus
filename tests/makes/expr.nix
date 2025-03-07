# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ omnibus, lib }:
let
  inherit (omnibus.flake.inputs) nixpkgs makesSrc pogSrc;
  omnibusLib =
    (omnibus.pops.self.addLoadExtender {
      load = {
        inputs = {
          inputs = {
            nixpkgs = nixpkgs.legacyPackages.x86_64-linux;
            inherit makesSrc;
          };
        };
      };
    }).exports.default;

  inherit (omnibusLib.ops.makes) makeScript;
in
{
  scripts =
    (omnibus.pops.scripts.addLoadExtender {
      load = {
        src = ./__fixture;
        inputs = {
          inputs = {
            nixpkgs = nixpkgs.legacyPackages.x86_64-linux;
            inherit pogSrc;
            inherit makesSrc;
          };
        };
      };
    }).exports.default;
  inherit makeScript;
}

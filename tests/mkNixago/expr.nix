# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ omnibus, system }:
let
  inherit (omnibus.flake.inputs) nixpkgs nixago;
  mkNixago =
    (omnibus.pops.self.addLoadExtender {
      load = {
        inputs = {
          inputs = {
            nixpkgs = nixpkgs.legacyPackages.${system};
            inherit nixago;
          };
        };
      };
    }).exports.default.ops.mkNixago;
in
mkNixago {
  data = {
    foo = "bar";
    baz = [
      1
      2
      3
    ];
  };
  output = "./example.yaml";
  format = "yaml";
  hook.mode = "copy";
}

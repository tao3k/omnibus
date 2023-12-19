# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ inputs, cell }:
let
  inherit (inputs) nixpkgs;
  inputs' = (inputs.omnibus.pops.flake.setSystem nixpkgs.system).inputs;
  inherit (inputs.omnibus.pops.self.load.inputs) POP flops;
in
{
  devshellProfiles =
    (inputs.omnibus.pops.devshellProfiles.addLoadExtender {
      load.inputs.inputs = inputs';
    }).addExporter
      (
        POP.extendPop flops.haumea.pops.exporter (
          _self: _super: {
            exports = rec {
              inherit (inputs.omnibus.lib.omnibus.mapPopsExports pops) self;
              pops.self =
                (self.layouts.default.addLoadExtender {
                  load.inputs = {
                    # extend the inputs of the default layout
                    # inherit inputs cell;
                  };
                });
            };
          }
        )
      );

  configs = inputs.omnibus.pops.configs {
    inputs = {
      inputs = {
        inherit (inputs') nixfmt nur;
        inherit (inputs) std;
        inherit nixpkgs;
      };
    };
  };
}

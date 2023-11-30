# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

let
  inherit (inputs) dmerge;
in
(omnibus.pops.homeModules.addLoadExtender {
  load.inputs = {
    inputs = {
      inherit (super.flake.inputs) catppuccin-bat;
    };
  };
}).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: _super: {
        exports.customModules = self.outputs [
          {
            value = {
              enable = false;
              customList = with dmerge; append ["1"];
              imports = with dmerge; append [];
            };
            path = [
              "services"
              "openssh"
            ];
          }
        ];
      }
    ))
  ]

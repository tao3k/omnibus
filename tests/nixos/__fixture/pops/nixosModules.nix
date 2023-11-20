# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

let
  inherit (inputs) dmerge;
in
(omnibus.pops.nixosModules.addLoadExtender {
  load.inputs = {
    inputs = super.flake.inputs;
  };
}).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: _super: {
        exports.customModules =
          with dmerge;
          self.outputs [
            ({
              value =
                { selfModule' }:
                selfModule' (
                  m:
                  dmerge
                    (lib.removeAttrs m
                      [
                        # popup the imports, so that we can use own nixosModule
                        # "imports"
                      ]
                    )
                    {
                      config.boot.contents = update [ 0 ] [
                        {
                          content = {
                            loader.timeout.content = 10;
                            # loader.efi.canTouchEfiVariables = false;
                          };
                        }
                      ];
                    }
                );
              path = [ "boot" ];
            })
          ];
      }
    ))
  ]

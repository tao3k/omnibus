# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

let
  inherit (inputs) dmerge;
in
(omnibus.pops.nixosProfiles.addLoadExtender {
  load = {
    inputs = {
      inputs = super.flake.inputs;
      omnibus = {
        nixosModules = super.nixosModules.exports.default;
      };
    };
  };
}).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: _super: {
        exports.customProfiles = self.outputs [
          {
            value =
              {selfModule'}:
              selfModule' (
                m:
                dmerge m {
                  config.nix.extraOptions = ''
                    allowed-uris = https://github.com/
                  '';
                }
              );
            path = [
              "presets"
              "nix"
            ];
          }
          {
            # boot.__profiles__.systemd-initrd.enable = true;
            value =
              {selfModule'}:
              selfModule' (
                m: dmerge m {config.boot.__profiles__.systemd-boot.enable = true;}
              );
            path = [
              "presets"
              "boot"
            ];
          }
        ];
      }
    ))
  ]

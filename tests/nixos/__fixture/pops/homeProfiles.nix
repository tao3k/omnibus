# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

let
  inherit (inputs) dmerge;
in
(omnibus.pops.homeProfilesOmnibus.addLoadExtender {
  load.inputs = {
    omnibus = {
      homeModules = super.homeModules.exports.default;
    };
    inputs = {
      inherit (omnibus.flake.inputs) nur nix-filter navi-tldr-pages;
    };
  };
}).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: _super: {
        exports.customProfiles = self.outputs [
          {
            value =
              { selfModule' }:
              with dmerge;
              selfModule' (
                m:
                dmerge m {
                  config.wayland.windowManager.hyprland.__profiles__ = {
                    nvidia.content = true;
                  };
                }
              );
            path = [
              "presets"
              "hyprland"
              "default"
            ];
          }
        ];
      }
    ))
  ]

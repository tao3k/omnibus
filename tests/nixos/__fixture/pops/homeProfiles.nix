# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

let
  inherit (inputs) dmerge;
in
(omnibus.pops.homeProfiles.addLoadExtender {
  load.inputs = {
    omnibus = {
      homeModules = super.homeModules.layouts.nixosModules;
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
                  wayland.windowManager.hyprland.__profiles__ = {
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

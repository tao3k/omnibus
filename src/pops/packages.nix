# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

# [[id:f7adb0ad-2cc1-4723-a796-bf608682456a][No heading:1]]
{ super, root }:
load:
let
  inherit
    (root.errors.requiredInputs load.inputs "omnibus.pops.packages" [ "nixpkgs" ])
    nixpkgs
  ;
  inherit (nixpkgs) newScope;
  inherit (nixpkgs.lib) makeScope;
in
makeScope newScope (
  selfScope:
  ((super.load load).addLoadExtender {
    load = {
      loader =
        __inputs__: path:
        (selfScope.overrideScope (_: _: { inherit __inputs__; })).callPackage path { };
      transformer = [ (_cursor: dir: if dir ? default then dir.default else dir) ];
    };
  }).addExporters
    [
      (POP.extendPop flops.haumea.pops.exporter (
        self: _super: {
          exports = {
            overlay =
              final: prev:
              (self.layouts.self.addLoadExtender {
                load = {
                  inputs.inputs.nixpkgs = final;
                  loader =
                    __inputs__: path:
                    (__inputs__.inputs.nixpkgs.extend (_: _: { inherit __inputs__; })).callPackage
                      path
                      { };
                };
              }).exports.default;
          };
        }
      ))
    ]
)
# No heading:1 ends here

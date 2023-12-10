# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

# [[id:f7adb0ad-2cc1-4723-a796-bf608682456a][No heading:1]]
{
  super,
  root,
  POP,
  flops,
  lib,
}:
load:
let
  inherit (flops) recursiveMerge';
  inherit (root.pops.flake.inputs) nix-filter;
in
(super.load (
  recursiveMerge' [
    {
      loader =
        __inputs__: path:
        #  without the scope loader
        (__inputs__.inputs.nixpkgs.extend (_: _: {inherit __inputs__;})).callPackage
          path
          {};
      transformer = [(_cursor: dir: if dir ? default then dir.default else dir)];
    }
    load
  ]
)).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: _super: {
        exports =
          let
            inherit
              (root.errors.requiredInputs self.layouts.self.load.inputs.inputs
                "omnibus.pops.packages"
                ["nixpkgs"]
              )
              nixpkgs
              ;
            inherit (nixpkgs) newScope;
            inherit (nixpkgs.lib) makeScope;
          in
          {
            derivations =
              lib.attrsets.filterDerivations self.exports.packages
              // (lib.optionalAttrs (self.exports.packages ? omnibus)
                lib.attrsets.filterDerivations
                (lib.concatMapAttrs (_: v: v) self.exports.packages.omnibus)
              );

            scopePackagesPop =
              selfScope:
              (self.layouts.self.addLoadExtender {
                load = {
                  loader =
                    __inputs__: path:
                    (selfScope.overrideScope (_: _: {inherit __inputs__;})).callPackage path {};
                  inputs = {
                    callPackagesWithOmnibus =
                      selfScope: src:
                      (super.load {
                        loader =
                          _: path:
                          (selfScope.overrideScope (_: _: {__inputs__ = self.layouts.self.load.inputs;}))
                          .callPackage
                            path
                            {};
                        src = nix-filter.lib.filter {
                          root = src;
                          exclude = ["default.nix"];
                        };
                        transformer = [(_cursor: dir: if dir ? default then dir.default else dir)];
                      }).exports.default;
                  };
                };
              });

            packages = makeScope newScope (
              selfScope: (self.exports.scopePackagesPop selfScope).exports.default
            );

            overlays = {
              default =
                final: prev:
                (self.exports.packages.packages (
                  final // {overrideScope = self.exports.packages.overrideScope;}
                ));
              compose =
                final: prev:
                ((self.exports.packages.overrideScope (
                  _: scopeSuper: {
                    python3 = prev.python3.override (
                      old: {
                        packageOverrides =
                          prev.lib.composeExtensions (old.packageOverrides or (_: _: {}))
                            (
                              pythonSelf: _:
                              if (scopeSuper ? omnibus && scopeSuper.omnibus ? python3Packages) then
                                scopeSuper.omnibus.python3Packages.packages pythonSelf
                              else
                                {}
                            );
                      }
                    );
                    python3Packages = prev.python3Packages.override (
                      old: {
                        overrides = prev.lib.composeExtensions (old.overrides or (_: _: {})) (
                          pythonSelf: _:
                          if (scopeSuper ? omnibus && scopeSuper.omnibus ? python3Packages) then
                            scopeSuper.omnibus.python3Packages.packages pythonSelf
                          else
                            {}
                        );
                      }
                    );
                  }
                )).packages
                  (final // {overrideScope = self.exports.packages.overrideScope;})
                );
            };
          };
      }
    ))
  ]
# No heading:1 ends here

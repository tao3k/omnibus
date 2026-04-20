# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  super,
  root,
  POP,
  flops,
  lib,
  inputs,
}:
let
  /**
    Package loaders often use nested `default.nix` entrypoints, so collapse
    those directories before exporting the package scope.
  */
  flattenDefaultDir = _cursor: dir: if dir ? default then dir.default else dir;
in
(super.load.withInitLoad {
  loader =
    __inputs__: path:
    (__inputs__.inputs.nixpkgs.extend (_: _: { inherit __inputs__; })).callPackage path { };
  transformer = [ flattenDefaultDir ];
}).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: _super: {
        exports =
          let
            inherit
              (root.errors.requiredInputsLazily self.layouts.self.load.inputs.inputs "omnibus.pops.packages" [
                "nixpkgs"
              ])
              nixpkgs
              ;
            inherit (nixpkgs) newScope;
            inherit (nixpkgs.lib) makeScope;
            /**
              Reuse the same scoped `callPackage` wiring in both the main
              package loader and nested by-loader entrypoints.
            */
            callPackageWithScope =
              selfScope: inputMapper: __inputs__: path:
              (selfScope.overrideScope (_: _: inputMapper __inputs__)).callPackage path { };
            /**
              Feed python package overlays from the optional by-loader scope
              back into both `python3` and `python3Packages` entrypoints.
            */
            python3PackagesOverlay =
              scopeSuper: pythonSelf: _:
              if (scopeSuper ? by-loader && scopeSuper.by-loader ? python3Packages) then
                scopeSuper.by-loader.python3Packages.packages pythonSelf
              else
                { };
          in
          {
            derivations = inputs.self.flake.inputs.flake-utils.lib.flattenTree (
              self.exports.packages // self.exports.packages.by-loader
            );

            /**
              Build a package pop that evaluates units with a caller-provided
              scope, which is later used to assemble the public package scope.
            */
            scopePackagesPop =
              selfScope:
              (self.layouts.self.addLoadExtender {
                load = {
                  loader = callPackageWithScope selfScope (__inputs__: {
                    inherit __inputs__;
                  });
                  inputs = { };
                };
              });

            packages =
              (makeScope newScope (selfScope: (self.exports.scopePackagesPop selfScope).exports.default))
              .overrideScope
                (
                  selfScope: _: {
                    by-loader =
                      lib.optionalAttrs (lib.pathExists (self.layouts.self.load.src + "/by-loader/python3Packages"))
                        {
                          python3Packages = (selfScope.callPackage lib.omnibus.mkPython3PackagesWithScope { }).overrideScope (
                            _: _: { recurseForDerivations = true; }
                          );
                        };
                    __inputs__ = {
                      __load__ = self.layouts.self.load;
                      callPackagesWithLoader =
                        selfScope: src:
                        assert lib.assertMsg (!(lib.readDir src) ? "default.nix") ''
                          The top-level of ${src} must not contain a file named "default.nix"
                        '';
                        /**
                          Nested by-loader trees should see the original load
                          inputs, not only the transient scoped call inputs.
                        */
                        (super.load {
                          loader = callPackageWithScope selfScope (_: {
                            __inputs__ = self.layouts.self.load.inputs;
                          });
                          inherit src;
                          transformer = [ flattenDefaultDir ];
                        }).exports.default;
                    };
                  }
                );

            overlays = {
              default =
                final: _prev:
                (self.exports.packages.packages (
                  final // { overrideScope = self.exports.packages.overrideScope; }
                ));
              composedPackages =
                final: prev:
                (
                  (self.exports.packages.overrideScope (
                    _: scopeSuper: {
                      python3 = prev.python3.override (old: {
                        packageOverrides = prev.lib.composeExtensions (old.packageOverrides or (_: _: { })) (
                          python3PackagesOverlay scopeSuper
                        );
                      });
                      python3Packages = prev.python3Packages.override (old: {
                        overrides = prev.lib.composeExtensions (old.overrides or (_: _: { })) (
                          python3PackagesOverlay scopeSuper
                        );
                      });
                    }
                  )).packages
                  (final // { overrideScope = self.exports.packages.overrideScope; })
                );
            };
          };
      }
    ))
  ]

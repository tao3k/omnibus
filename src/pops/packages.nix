# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

# [[id:f7adb0ad-2cc1-4723-a796-bf608682456a][No heading:1]]
{
  super,
  root,
  POP,
  flops,
  lib,
  inputs,
}:
(super.load.setInit {
  loader =
    __inputs__: path:
    #  without the scope loader
    (__inputs__.inputs.nixpkgs.extend (_: _: { inherit __inputs__; })).callPackage
      path
      { };
  transformer = [ (_cursor: dir: if dir ? default then dir.default else dir) ];
}).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: _super: {
        exports =
          let
            inherit
              (root.errors.requiredInputsLazily self.layouts.self.load.inputs.inputs
                "omnibus.pops.packages"
                [ "nixpkgs" ]
              )
              nixpkgs
              ;
            inherit (nixpkgs) newScope;
            inherit (nixpkgs.lib) makeScope;
          in
          {
            derivations = inputs.self.flake.inputs.flake-utils.lib.flattenTree (
              self.exports.packages // self.exports.packages.by-loader
            );

            scopePackagesPop =
              selfScope:
              (self.layouts.self.addLoadExtender {
                load = {
                  loader =
                    __inputs__: path:
                    (selfScope.overrideScope (_: _: { inherit __inputs__; })).callPackage path { };
                  inputs = { };
                };
              });

            packages =
              (makeScope newScope (
                selfScope: (self.exports.scopePackagesPop selfScope).exports.default
              )).overrideScope
                (
                  selfScope: _:
                  let
                    checkPath =
                      pathSuffix:
                      if lib.pathExists (self.layouts.self.load.src + pathSuffix) then
                        true
                      else
                        false;
                  in
                  {
                    by-loader = lib.optionalAttrs (checkPath "/by-loader/python3Packages") {
                      python3Packages =
                        (selfScope.callPackage lib.omnibus.mkPython3PackagesWithScope { }).overrideScope
                          (_: _: { recurseForDerivations = true; });
                    };
                    __inputs__ = {
                      __load__ = self.layouts.self.load;
                      callPackagesWithLoader =
                        selfScope: src:
                        assert lib.assertMsg (!(lib.readDir src) ? "default.nix") ''
                          The top-level of ${src} must not contain a file named "default.nix"
                        '';
                        (super.load {
                          loader =
                            _: path:
                            (selfScope.overrideScope (
                              _: _: { __inputs__ = self.layouts.self.load.inputs; }
                            )).callPackage
                              path
                              { };
                          inherit src;
                          transformer = [ (_cursor: dir: if dir ? default then dir.default else dir) ];
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
                        packageOverrides =
                          prev.lib.composeExtensions (old.packageOverrides or (_: _: { }))
                            (
                              pythonSelf: _:
                              if (scopeSuper ? by-loader && scopeSuper.by-loader ? python3Packages) then
                                scopeSuper.by-loader.python3Packages.packages pythonSelf
                              else
                                { }
                            );
                      });
                      python3Packages = prev.python3Packages.override (old: {
                        overrides = prev.lib.composeExtensions (old.overrides or (_: _: { })) (
                          pythonSelf: _:
                          if (scopeSuper ? by-loader && scopeSuper.by-loader ? python3Packages) then
                            scopeSuper.by-loader.python3Packages.packages pythonSelf
                          else
                            { }
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
# No heading:1 ends here

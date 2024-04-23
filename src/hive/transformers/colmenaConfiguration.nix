# SPDX-FileCopyrightText: 2024 The divnix/hive Authors
#
# SPDX-License-Identifier: Unlicense

{
  inputs,
  super,
  lib,
}:
{ evaled, locatedConfig }:
let
  inherit (evaled.config.bee) colmena;

  l = lib // builtins;

  isDarwin = evaled.config.bee.pkgs.stdenv.isDarwin;

  colmenaModules =
    l.map
      (l.setDefaultModuleLocation (./colmenaConfigurations.nix + ":colmenaModules"))
      [
        # these modules are tied to the below schemaversion
        # so we fix them here
        colmena.nixosModules.assertionModule
        colmena.nixosModules.keyChownModule
        colmena.nixosModules.deploymentOptions
        {
          environment.etc."nixos/configuration.nix".text = ''
            throw '''
              This machine is not managed by nixos-rebuild, but by colmena.
            '''
          '';
        }
      ]
    ++ (l.optionals (!isDarwin) [ colmena.nixosModules.keyServiceModule ]);

  config = {
    imports = [ locatedConfig ] ++ colmenaModules;
  };
in
if isDarwin then
  super.darwinConfiguration {
    inherit evaled;
    locatedConfig = config;
  }
else
  super.nixosConfiguration {
    inherit evaled;
    locatedConfig = config;
  }

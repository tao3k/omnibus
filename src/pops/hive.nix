# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  POP,
  lib,
  flops,
  super,
  root,
  projectRoot,
}:
let
  inherit (POP) pop extendPop;
  inherit (lib) fix;
in
/*
     bee = {
      home = {};
      nixpkgs = {};
      nixos = {};
    }
*/
(pop {
  defaults = {
    hosts = { };
    pops = {
      omnibus = { };
      nixosProfiles = { };
      nixosModules = { };
    };
    inputs = {
      inherit (super.flake.inputs) colmena nixpkgs;
    };
    system = "";
    nixosConfigurationRenamer = "nixosConfiguration";
    darwinConfigurationRenamer = "darwinConfiguration";
    colmenaConfigurationRenamer = "colmenaConfiguration";
    exports = {
      hosts = { };
    };
  };
  extension =
    final: prev:
    let
      hostsArgs = {
        inherit (final) hosts system inputs;
      };
    in
    {
      colmena = final.genColmenaFromHosts (
        lib.filterAttrs (n: v: v.bee ? "colmena") prev.hosts
      );
      genColmenaFromHosts = hosts: {
        meta = {
          nodes = lib.mapAttrs (hostName: hostConfig: {
            inherit (hostConfig.meta.colmena) imports deployment;
          }) hosts;
          nodeNixpkgs = lib.mapAttrs (
            hostName: hostConfig: (super.types.hive.colmena hostConfig.meta.colmena).nixpkgs
          ) hosts;
        };
      };
      setHosts =
        setHosts: extendPop final (_: superP: { hosts = superP.hosts // setHosts; });
      setSystem = system: extendPop final (_: _: { inherit system; });

      addMapLoadToPops = load: { };

      addInputs = inputs: extendPop final (_: _: { inputs = prev.inputs // inputs; });

      setNixosConfigurationsRenamer =
        renamer: extendPop final (_: _: { nixosConfigurationRenamer = renamer; });

      setDarwinConfigurationsRenamer =
        renamer: extendPop final (_: _: { darwinConfigurationRenamer = renamer; });

      setColmenaConfigurationsRenamer =
        renamer: extendPop final (_: _: { colmenaConfigurationRenamer = renamer; });

      pops = { };
      exports = {
        darwinConfiguraitons = root.hive.collectors.darwinConfigurations final.darwinConfigurationRenamer hostsArgs;

        colmenaHive = root.hive.collectors.colmenaConfigurations final.colmenaConfigurationRenamer hostsArgs;

        nixosConfigurations = root.hive.collectors.nixosConfigurations final.nixosConfigurationRenamer hostsArgs;
        # hosts = lib.omnibus.mkHosts {
        #   # hostsDir = projectRoot + "/units/nixos/hosts";
        #   hostsDir = ./.;
        #   pops = super.hostsInterface;
        #   addLoadExtender = {
        #     load = { };
        #   };
        # };
      };
    };
})

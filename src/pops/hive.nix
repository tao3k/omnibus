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
in
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
    homeConfigurationRenamer = "homeConfiguration";
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
      /**
        Most mutators only override a single field, so keep that pattern in one
        helper to make the pop surface easier to scan.
      */
      setField = name: value: extendPop final (_: _: { ${name} = value; });
      /**
        All configuration collectors share the same hosts/system/inputs payload
        and only differ by renamer and collector implementation.
      */
      collectConfigurations = renamerName: collector: collector final.${renamerName} hostsArgs;
    in
    {
      colmena = final.genColmenaFromHosts (lib.filterAttrs (_: v: v.bee ? "colmena") prev.hosts);
      genColmenaFromHosts =
        hosts:
        let
          /**
            Normalize the per-host Colmena metadata once so both node exports
            and nodeNixpkgs derive from the same source data.
          */
          colmenaMetaByHost = lib.mapAttrs (_: hostConfig: hostConfig.meta.colmena) hosts;
        in
        {
          meta = {
            nodes = lib.mapAttrs (_: colmenaMeta: {
              inherit (colmenaMeta) imports deployment;
            }) colmenaMetaByHost;
            nodeNixpkgs = lib.mapAttrs (
              _: colmenaMeta: (super.types.hive.colmena colmenaMeta).nixpkgs
            ) colmenaMetaByHost;
          };
        };
      setHosts = setHosts: extendPop final (_: superP: { hosts = superP.hosts // setHosts; });
      /**
        Merge additional pops into the hive surface so helper combinators can
        propagate shared load selectors across them.
      */
      setPops = pops: extendPop final (_: superP: { pops = superP.pops // pops; });
      setSystem = system: setField "system" system;

      /**
        Keep the compatibility surface for downstream callers that still expect
        hive pops to expose this hook.
      */
      addMapLoadToPops =
        load:
        extendPop final (
          _: superP: {
            pops = root.lib.omnibus.mapLoadToPops superP.pops load;
          }
        );

      addInputs = inputs: extendPop final (_: _: { inputs = prev.inputs // inputs; });

      setNixosConfigurationsRenamer = renamer: setField "nixosConfigurationRenamer" renamer;

      setHomeConfigurationsRenamer = renamer: setField "homeConfigurationRenamer" renamer;

      setDarwinConfigurationsRenamer = renamer: setField "darwinConfigurationRenamer" renamer;

      setColmenaConfigurationsRenamer = renamer: setField "colmenaConfigurationRenamer" renamer;

      exports = {
        darwinConfigurations = collectConfigurations "darwinConfigurationRenamer" root.hive.collectors.darwinConfigurations;

        colmenaHive = collectConfigurations "colmenaConfigurationRenamer" root.hive.collectors.colmenaConfigurations;

        nixosConfigurations = collectConfigurations "nixosConfigurationRenamer" root.hive.collectors.nixosConfigurations;

        homeConfigurations = collectConfigurations "homeConfigurationRenamer" root.hive.collectors.homeConfigurations;
      };
    };
})

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
    system = "";
    nixosConfigurationRenamer = "nixosConfiguration";
    exports = {
      hosts = { };
    };
  };
  extension = final: prev: {
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

    setNixosConfigurationsRenamer =
      renamer: extendPop final (_: _: { nixosConfigurationRenamer = renamer; });

    pops = { };
    exports = {
      darwinConfiguraitons =
        root.hive.collectors.darwinConfigurations "darwinConfiguration" final.hosts
          final.system;

      colmenaHive =
        root.hive.collectors.colmenaConfigurations "colmenaConfiguration" final.hosts
          final.system;

      nixosConfigurations =
        root.hive.collectors.nixosConfigurations final.nixosConfigurationRenamer
          final.hosts
          final.system;
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

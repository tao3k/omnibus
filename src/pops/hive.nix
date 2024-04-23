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
    addMapLoadToPops = load: { };

    darwinConfiguraitons = root.hive.collectors.darwinConfigurations "darwinConfiguration" final.hosts;

    colmenaHive = root.hive.collectors.colmenaConfigurations "colmetaConfiguration" final.hosts;

    nixosConfigurations = root.hive.collectors.nixosConfigurations final.nixosConfigurationRenamer final.hosts;
    setNixosConfigurationRenamer =
      renamer: extendPop final (_: _: { nixosConfigurationRenamer = renamer; });

    pops = { };
    exports = {
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

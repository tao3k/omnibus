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
  inherit (POP) pop;
  hosts = root.load { src = projectRoot + "/templates/nixos/units/nixos/hosts"; };
in
/*
     bee = {
      home = {};
      nixpkgs = {};
      nixos = {};
    }
*/
(
  setHosts:
  pop {
    defaults = {
      hosts = lib.mapAttrs (
        hostName: hostConfig:
        (hostConfig)
        // {
          bee = (hostConfig.bee or { }) // (removeAttrs hostConfig [ "bee" ]);
        }
      ) setHosts;
      pops = {
        omnibus = { };
        nixosProfiles = { };
        nixosModules = { };
      };
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
            inherit (hostConfig.bee.colmena) imports deployment;
          }) hosts;
          nodeNixpkgs = lib.mapAttrs (
            hostName: hostConfig: (super.types.bee.colmena hostConfig.bee.colmena).nixpkgs
          ) hosts;
        };
      };
      addMapLoadToPops = load: { };

      nixosConfigurations = lib.mapAttrs (
        hostName: hostConfig:
        let
          nixosConfiguration = hostConfig.bee.nixosConfiguration or { };
        in
        nixosConfiguration
      ) hosts;

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
  }
)
  hosts

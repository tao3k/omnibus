{
  lib,
  inputs,
  super,
  omnibus,
  root,
}:
let
  hostsDir = lib.attrNames (lib.readDir (projectDir + "/units/nixos/hosts"));
  inherit (omnibus.lib) addLoadToPops;
in
addLoadToPops hostsDir super.hostsLoad (
  elm: n: v: {
    load.src = root.filterPopsSrc (projectDir + "/units/nixos/hosts/${elm}") n;
  }
)

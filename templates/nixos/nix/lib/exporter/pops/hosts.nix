{
  lib,
  inputs,
  super,
  omnibus,
  root,
}:
let
  hostsDir = lib.attrNames (
    lib.readDir (inputs.self.outPath + "/units/nixos/hosts")
  );
  inherit (omnibus.lib) addLoadToPops;
in
addLoadToPops hostsDir super.hostsLoad (
  elm: n: v: {
    load.src =
      root.filterPopsSrc (inputs.self.outPath + "/units/nixos/hosts/${elm}")
        n;
  }
)

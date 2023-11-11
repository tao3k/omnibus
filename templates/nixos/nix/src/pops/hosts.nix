{
  lib,
  super,
  omnibus,
  root,
  projectDir,
}:
let
  hostsDir = (projectDir + "/units/nixos/hosts");
  inherit (omnibus.lib) addLoadToPopsFilterBySrc;
in
addLoadToPopsFilterBySrc hostsDir super.hostsLoad { }

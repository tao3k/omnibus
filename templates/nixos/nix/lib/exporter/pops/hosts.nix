{
  lib,
  inputs,
  super,
}:
let
  hostsDir = lib.attrNames (lib.readDir (inputs.self.outPath + "/nixos/hosts"));
in
lib.listToAttrs (
  map
    (name: {
      inherit name;
      value = lib.mapAttrs (_: v: v name) super.hostsFun;
    })
    hostsDir
)

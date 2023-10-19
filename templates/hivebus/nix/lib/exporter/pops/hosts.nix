{
  lib,
  inputs,
  super,
  root,
}:
let
  hostsDir = lib.attrNames (
    lib.readDir (inputs.self.outPath + "/units/nixos/hosts")
  );
in
lib.listToAttrs (
  map
    (name: {
      inherit name;
      value =
        lib.mapAttrs
          (
            n: v:
            v.addLoadExtender {
              load.src =
                root.filterPopsSrc (inputs.self.outPath + "/units/nixos/hosts/${name}")
                  n;
            }
          )
          super.hostsLoad;
    })
    hostsDir
)

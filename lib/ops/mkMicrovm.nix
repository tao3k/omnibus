# credit: https://github.com/divnix/std/blob/main/src/lib/ops/mkMicrovm.nix#
{
  inputs,
  lib,
  root,
}:
let
  inherit
    (root.errors.requiredInputs inputs "lib" [
      "nixpkgs"
      "microvm"
    ])
    nixpkgs
    microvm
  ;
  nixosSystem =
    args:
    import "${nixpkgs.path}/nixos/lib/eval-config.nix" (
      args // { modules = args.modules; }
    );
in
module:
nixosSystem {
  inherit (nixpkgs) system;
  modules = [
    # for declarative MicroVM management
    microvm.nixosModules.host
    # this runs as a MicroVM that nests MicroVMs
    microvm.nixosModules.microvm
    # your custom module
    module
  ];
}

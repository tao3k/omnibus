# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

# credit: https://github.com/divnix/std/blob/main/src/lib/ops/mkMicrovm.nix#
{ inputs, root }:
let
  inherit
    (root.errors.requiredInputsLazily inputs "lib" [
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

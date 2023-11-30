# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  inputs = {
    omnibus.url = "github:gtrunsec/omnibus";
  };

  outputs =
    {...}@inputs:
    let
      inherit (inputs.omnibus.inputs.flops.inputs.nixlib) lib;
      eachSystem = lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      srcPops = import ./nix/src/__init.nix {inherit inputs eachSystem;};
      src = srcPops.exports.default;
    in
    src.flakeOutputs
    // {
      inherit src;
      inherit (src) lib;
      pops = src.pops;
    };
}

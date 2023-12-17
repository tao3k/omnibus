# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  inputs = {
    omnibus.url = "github:gtrunsec/omnibus";
  };

  outputs =
    { ... }@inputs:
    let
      inherit (inputs.omnibus.inputs.flops.inputs.nixlib) lib;
      eachSystem = lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      srcPop = import ./nix/src { inherit inputs eachSystem; };
      src = srcPop.exports.default;
    in
    src.flakeOutputs
    // {
      inherit src;
      pops = src.pops // {
        self = srcPop;
      };
    };
}

# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  inputs = {
    flops.url = "github:gtrunsec/flops";
  };

  outputs =
    {self, ...}@inputs:
    let
      srcPops = import ./src/__init.nix {inherit inputs;};
      src = srcPops.exports.default;
    in
    src.flakeOutputs
    // {
      pops = src.pops // {
        self = srcPops;
      };

      inherit src;
      inherit (src) lib ops errors;

      nixci.default = {
        dir1.dir = "./local/ci";
      };

      templates = {
        nixos = {
          path = ./templates/nixos;
          description = "Omnibus & nixos";
          welcomeText = ''
            You have created an Omnibus.nixos template!
          '';
        };
        hivebus = {
          path = ./templates/hivebus;
          description = "Omnibus & hive";
          welcomeText = ''
            You have created a hivebus template!
          '';
        };
        simple = {
          path = ./templates/simple;
          description = "Omnibus & simple case";
          welcomeText = ''
            You have created a simple case template!
          '';
        };
      };
    };
}

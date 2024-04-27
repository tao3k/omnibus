# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

let
  inherit (inputs) nixpkgs;
  inputs' = (inputs.omnibus.pops.flake.setSystem nixpkgs.system).inputs;
in
{
  omnibus = {
    devshellProfiles = inputs.omnibus.pops.devshellProfiles.addLoadExtender {
      load.inputs.inputs = inputs';
    };
    configs = inputs.omnibus.pops.configs {
      inputs = {
        inputs = {
          inherit (inputs') nixfmt git-hooks;
          inherit (inputs) std;
          inherit nixpkgs;
        };
      };
    };
  };
}

# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

(omnibus.pops.flake.addInputsExtender (
  POP.extendPop flops.flake.pops.inputsExtender (
    _self: _super:
    let
      selfInputs = omnibus.pops.flake.setInitInputs ../__lock;
      local = omnibus.pops.flake.setInitInputs (projectDir + "/local");
    in
    {
      inputs = {
        std = local.outputs.std;
      } // selfInputs.inputs;
    }
  )
)).setSystem
  root.layouts.system

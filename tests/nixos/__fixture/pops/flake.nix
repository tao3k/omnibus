# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

(omnibus.pops.flake.addInputsExtender (
  POP.extendPop flops.flake.pops.inputsExtender (
    _self: _super:
    let
      selfInputs = omnibus.pops.flake.setInitInputs ../__lock;
      local = omnibus.pops.flake.setInitInputs (projectRoot + "/local");
    in
    {
      inputs = {
        std = local.outputs.std;
      } // selfInputs.inputs;
    }
  )
)).setSystem
  root.layouts.system

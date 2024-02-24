# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

(omnibus.pops.flake.addInputsExtender (
  POP.extendPop flops.flake.pops.inputsExtender (
    _self: _super:
    let
      subflake = omnibus.pops.flake.setInitInputs (projectRoot + /nix/lock);
    in
    {
      inputs = subflake.inputs;
    }
  )
))

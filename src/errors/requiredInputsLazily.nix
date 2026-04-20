# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ super, lib }:
inputs: popName: listInputs:
let
  /**
    Resolve each required input through `requiredInputs` one key at a time so
    callers can keep the lazy access pattern of their pop definitions.
  */
  getRequiredInput = key: (super.requiredInputs inputs popName [ key ]).${key};
in
lib.genAttrs listInputs (name: getRequiredInput name)

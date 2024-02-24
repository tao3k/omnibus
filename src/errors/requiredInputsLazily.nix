# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ super, lib }:
inputs: popName: listInputs:
let
  getRequiredInput = key: (super.requiredInputs inputs popName [ key ]).${key};
in
lib.genAttrs listInputs (name: getRequiredInput name)

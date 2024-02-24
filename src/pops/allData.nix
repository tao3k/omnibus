# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  super,
  root,
  haumea,
}:
(super.data.addLoadExtender {
  load = {
    loader = with haumea; [
      (matchers.regex "^(.+)\\.(yaml|yml)$" (
        _: inputs: path:
        let
          inherit
            (root.errors.requiredInputs inputs.inputs "omnibus.pops.allData" [ "nixpkgs" ])
            nixpkgs
            ;
        in
        root.ops.readYAML nixpkgs path
      ))
    ];
  };
})

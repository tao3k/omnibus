# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  haumea,
  flops,
  root,
}:
flops.haumea.pops.default.setInit {
  loader = with haumea; [
    matchers.json
    matchers.toml
    (matchers.nix loaders.scoped)
    (matchers.nix loaders.default)
    (matchers.regex "^(.+)\\.(yaml|yml)$" (
      _: inputs: path:
      if inputs ? inputs && inputs.inputs ? nixpkgs then
        root.ops.readYAML inputs.inputs.nixpkgs path
      else
        path
    ))
  ];
}

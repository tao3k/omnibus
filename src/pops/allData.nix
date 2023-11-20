# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  super,
  root,
  haumea,
  flops,
}:
(super.data.addLoadExtender {
  load = {
    loader = with haumea; [
      (matchers.regex "^(.+)\\.(yaml|yml)$" (
        _: _: path:
        root.ops.readYAML path
      ))
    ];
  };
})

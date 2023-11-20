# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

flops.haumea.pops.default.setInit {
  loader = with haumea; [
    matchers.json
    matchers.toml
    (matchers.nix loaders.scoped)
    (matchers.nix loaders.default)
  ];
}

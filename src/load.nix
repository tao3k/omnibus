# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ root }:
let
  load = root.pops.load;
in
/**
  Convenience wrapper that exposes only the default export of `root.pops.load`.
*/
loadCfg: (load loadCfg).exports.default

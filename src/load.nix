# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{root}:
let
  load = root.pops.load;
in
loadCfg:
(load loadCfg).exports.default

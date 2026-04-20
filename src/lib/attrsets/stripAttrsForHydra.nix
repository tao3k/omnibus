# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ super }:
/**
  Drop Hydra-specific control attributes while preserving the remaining nested
  shape.
*/
super.filterAttrsOnlyRecursive (n: _: n != "recurseForDerivations" && n != "dimension")

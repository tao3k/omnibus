# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ super }:
super.filterAttrsOnlyRecursive (
  n: _: n != "recurseForDerivations" && n != "dimension"
)

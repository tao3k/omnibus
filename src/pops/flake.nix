# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ projectDir, flops }:
flops.flake.pops.default.setInitInputs (projectDir + "/local/lock")

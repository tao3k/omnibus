# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ projectRoot, flops }: flops.flake.pops.default.withInitInputs (projectRoot + "/units/lock")

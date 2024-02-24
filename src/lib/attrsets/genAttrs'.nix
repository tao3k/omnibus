# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ ... }: values: f: builtins.listToAttrs (map f values)

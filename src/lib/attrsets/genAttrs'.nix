# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ ... }:
values: f:
/**
  Like `lib.genAttrs`, but the mapper returns complete `{ name, value }` pairs.
*/
builtins.listToAttrs (map f values)

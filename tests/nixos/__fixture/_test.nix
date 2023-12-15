# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

(
  { lib, options, ... }:
  {
    options = {
      __test__ = lib.mkOption {
        type = lib.types.attrs;
        default = { };
      };
    };
  }
)

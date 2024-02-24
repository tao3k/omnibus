# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  options.__profiles__ = with lib; {
    nurPkgs = mkOption {
      type = types.lazyAttrsOf types.raw;
      default = { };
    };
  };
}

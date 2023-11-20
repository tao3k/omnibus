# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  options.__profiles__ = with lib; {
    test = mkOption {
      type = types.str;
      default = "test";
    };
  };
}

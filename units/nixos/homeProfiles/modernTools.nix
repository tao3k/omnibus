# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ ... }:
{
  packages = [
    (
      { pkgs, ... }:
      {
        home.packages = [ pkgs.fd ];
      }
    )
  ];
}

# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ pkgs }:
{
  kernel.bash.omnibus = {
    enable = true;
    runtimePackages = [ pkgs.git ];
  };
}

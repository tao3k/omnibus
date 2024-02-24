# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ pkgs }:
{
  packages = [
    pkgs.ansible
    pkgs.ansible-lint
  ];
}

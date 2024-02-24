# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ pkgs, inputs }:
{
  programs.git.enable = true;
  environment.systemPackages = [
    pkgs.git
    # inputs.nixpkgs.gh
  ];
}

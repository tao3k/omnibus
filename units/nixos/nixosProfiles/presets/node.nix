# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    yarn
    nodejs
  ];
}

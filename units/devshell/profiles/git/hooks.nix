# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ extraModulesPath, lib }:
{
  imports = [ (extraModulesPath + "/git/hooks.nix") ];
  git.hooks.enable = lib.mkDefault true;
}

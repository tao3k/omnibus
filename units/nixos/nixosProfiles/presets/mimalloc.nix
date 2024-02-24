# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  environment.memoryAllocator.provider = "mimalloc";
  nixpkgs.overlays = [
    (_: prev: { dhcpcd = prev.dhcpcd.override { enablePrivSep = false; }; })
  ];
}

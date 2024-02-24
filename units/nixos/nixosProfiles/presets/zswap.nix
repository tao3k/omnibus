# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ omnibus, lib }:
{
  # zram
  imports = [ omnibus.nixosModules.services.zswap ];
  zramSwap.enable = lib.mkForce false;
  services.zswap = {
    enable = true;
    zpool = lib.mkDefault "zsmalloc";
  };
}

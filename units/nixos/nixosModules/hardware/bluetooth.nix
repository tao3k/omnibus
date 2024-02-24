# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ lib }:
{
  options.__profiles__ = with lib; {
    desktop = mkEnableOption (lib.mdDoc "Whether to enable desktop profile");
  };
}

# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ omnibus }:
{
  imports = [ omnibus.srvos.common.openssh ];
  services.openssh = {
    enable = true;
  };
}

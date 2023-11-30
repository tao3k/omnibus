# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{omnibus}:
{
  imports = [omnibus.srvos.common.openssh];
  services.openssh = {
    enable = true;
  };
}

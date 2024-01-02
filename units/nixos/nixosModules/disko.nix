# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ lib }:
{
  options.devices = with lib; {
    __profiles__ = {
      name = mkOption {
        type = types.str;
        default = "default";
        description = ''
          The name of the profile to use.
        '';
      };
      ssd = mkOption {
        type = types.bool;
        default = true;
        description = ''
          Whether to use the SSD profile
        '';
      };
      boot = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to boot the profile
        '';
      };
      device = mkOption {
        type = types.str;
        default = "default";
        description = ''
          The name of the device to use.
        '';
      };
    };
  };
}

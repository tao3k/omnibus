# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ lib, loadSubmodule }:
{
  imports = [ (loadSubmodule ./packages.nix) ];

  options.__profiles__ = with lib; {
    gui = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to enable the gui profile";
    };
    dockerCompose = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to enable the docker-compose profile";
    };
    user = mkOption {
      type = types.str;
      default = "";
      description = "The user to run the virtualization programs as";
    };
    nvidia = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to enable the nvidia profile";
    };
  };
}

# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  data = {
    tasks = {
      example = {
        args = ["action"];
        description = "Colmena build example Machine";
        content = ''
          colmena -f $PRJ_ROOT/nix/hive/flake.nix {{action}} --on hosts-example
        '';
      };
    };
  };
}

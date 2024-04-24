# SPDX-FileCopyrightText: 2024 The divnix/hive Authors
#
# SPDX-License-Identifier: Unlicense

{
  lib,
  root,
  super,
}:
let
  l = lib // builtins;

  inherit (root.hive) transformers;

  colmenaTopLevelCliSchema =
    comb:
    l.fix (this: {
      __schema = "v0";

      nodes = l.mapAttrs (_: c: c.bee._evaled) comb;
      toplevel = l.mapAttrs (_: v: v.config.system.build.toplevel) this.nodes;
      deploymentConfig = l.mapAttrs (_: v: v.config.deployment) this.nodes;
      deploymentConfigSelected =
        names: l.filterAttrs (name: _: l.elem name names) this.deploymentConfig;
      evalSelected = names: l.filterAttrs (name: _: l.elem name names) this.toplevel;
      evalSelectedDrvPaths =
        names: l.mapAttrs (_: v: v.drvPath) (this.evalSelected names);
      metaConfig = {
        name = "omnibus/hive";
        description = "A NixOS configuration for the Omnibus Hive";
        machinesFile = null;
        allowApplyAll = false;
      };
      introspect =
        f:
        f {
          # lib = nixpkgs.lib // builtins;
          # pkgs = nixpkgs.legacyPackages.${builtins.currentSystem};
          nodes = comb;
        };
    });
in
renamer: self: system:
colmenaTopLevelCliSchema (
  super.walk transformers.colmenaConfiguration [ ] renamer self system
)

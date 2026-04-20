# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  flops,
  lib,
  root,
  projectRoot,
  POP,
}:
load:
let
  inherit
    (root.errors.requiredInputsLazily load.inputs.inputs "omnibus.pops.configs" [
      "std"
    ])
    std
    ;
  inherit (std.lib.dev) mkNixago;
  inherit (std.lib) cfg;

  cfg' = cfg // {
    treefmt = {
      data = { };
      output = "treefmt.toml";
      format = "toml";
    };
  };

  /**
    Apply a nixago constructor across a nested layout tree until we reach leaf
    nodes that carry a `data` payload.
  */
  applyRecursive =
    mkFunc: layoutData:
    lib.mapAttrsRecursiveCond (as: !(lib.isAttrs as && as ? data)) (_n: v: mkFunc v) layoutData;

  /**
    Turn each std config layout into its `mkNixago`-derived output tree.
  */
  processStdNixagoLayouts =
    data: cfgName:
    applyRecursive (
      layoutData:
      if (lib.hasAttr cfgName cfg) then
        # Keep treefmt pinned to the std override until upstream catches up.
        mkNixago cfg'.${cfgName} layoutData
      else
        throw "Unknown layout: ${cfgName}"
    ) (data.layouts.default.${cfgName});
in
(
  (flops.haumea.pops.default.withInitLoad {
    src = projectRoot + "/units/configs";
    inputs = root.lib.omnibus.loaderInputs;
  }).addLoadExtender
  { inherit load; }
).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: _super: {
        exports = {
          stdNixago = lib.listToAttrs (
            map (name: lib.nameValuePair name (processStdNixagoLayouts self name)) (
              lib.attrNames self.layouts.default
            )
          );
        };
      }
    ))
  ]

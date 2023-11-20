# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  flops,
  lib,
  root,
  projectDir,
  POP,
}:
load:
let
  inherit
    (root.errors.requiredInputs load.inputs.inputs "omnibus.pops.configs" [ "std" ])
    std
  ;
  inherit (std.lib.dev) mkNixago;
  inherit (std.lib) cfg;

  applyRecursive =
    mkFunc: layoutData:
    lib.mapAttrsRecursiveCond (as: !(lib.isAttrs as && as ? data)) # Condition to check
      (_n: v: mkFunc v) # Function to apply
      layoutData;

  # Function to process each layout
  processLayouts =
    data: cfgName:
    applyRecursive
      (
        layoutData:
        if (lib.hasAttr cfgName cfg) then
          mkNixago cfg.${cfgName} layoutData
        else
          throw "Unknown layout: ${cfgName}"
      )
      (data.layouts.default.${cfgName});
in
((flops.haumea.pops.default.setInit {
  src = projectDir + "/units/configs";
  inputs = root.lib.loaderInputs;
}).addLoadExtender
  { inherit load; }
).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: _super: {
        exports = {
          stdNixago = lib.listToAttrs (
            map (name: lib.nameValuePair name (processLayouts self name)) (
              lib.attrNames self.layouts.default
            )
          );
        };
      }
    ))
  ]

# SPDX-FileCopyrightText: 2024 The divnix/hive Authors
#
# SPDX-License-Identifier: Unlicense

{ lib, root }:
let
  l = lib // builtins;

  inherit (root.hive) beeModule;

  check =
    locatedConfig:
    let
      checked = l.evalModules {
        modules = [
          # recursion encountered problem
          # This error will be triggered when you define an Option.path
          # from {boot,fileSystems,swapXxx} in other modules (Exp: (test with disko.module).
          # But using nixos' eval-config will not. Only in bee.check
          # So I dropped the locatedConfig here, only eval the beeConfig in  this stage
          # locatedConfig
          { bee = locatedConfig.bee; }
          beeModule
          {
            config._module.check = true;
            config._module.freeformType = l.types.unspecified;
          }
        ];
      };

      failedAsserts = map (x: x.message) (
        l.filter (x: !x.assertion) checked.config.bee._alerts
      );

      asserted =
        if failedAsserts != [ ] then
          throw "\nHive's layer sanitation boundary: \n${
            l.concatStringsSep "\n" (map (x: "- ${x}") failedAsserts)
          }"
        else
          checked;
    in
    assert l.isAttrs asserted;
    {
      inherit locatedConfig;
      evaled = asserted;
    };
in
check

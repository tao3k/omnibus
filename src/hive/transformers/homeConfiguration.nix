# SPDX-FileCopyrightText: 2024 The divnix/hive Authors
#
# SPDX-License-Identifier: Unlicense

{ lib, root }:
{
  evaled,
  locatedConfig,
  inputs ? { },
}:
let
  inherit (root.hive) beeModule;

  l = lib // builtins;

  hmLib = import (evaled.config.bee.home + /modules/lib/stdlib-extended.nix) l;

  hmModules = import (evaled.config.bee.home + /modules/modules.nix) {
    inherit (evaled.config.bee) pkgs;
    lib = hmLib;
    check = true;
    # we switch off the nixpkgs module, package instantiation needs
    # to happen on the `std` layer
    useNixpkgsModule = false;
  };
  eval =
    extra:
    lib.evalModules {
      specialArgs = rec {
        modulesPath = l.toString (evaled.config.bee.home + /modules);
        lib = hmLib;
      };
      modules = [
        beeModule
        locatedConfig
        extra
      ] ++ hmModules;
    };
  bee = evaled.config.bee // {
    _evaled = eval { config._module.check = true; };
    _unchecked = eval { config._module.check = false; };
  };
in
{
  inherit bee;
  # complete module set, can be lib.evalModuled as-is
  imports = [
    beeModule
    locatedConfig
  ] ++ hmModules;
}

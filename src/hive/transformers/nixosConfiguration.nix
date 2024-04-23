# SPDX-FileCopyrightText: 2024 The divnix/hive Authors
#
# SPDX-License-Identifier: Unlicense

{ lib, root }:
{ evaled, locatedConfig }:
let
  inherit (root.hive) beeModule;

  nixosModules = import (
    evaled.config.bee.pkgs.path + "/nixos/modules/module-list.nix"
  );

  extraConfig = {
    nixpkgs = {
      inherit (evaled.config.bee) system pkgs;
    };
  };
  eval =
    extra:
    import (evaled.config.bee.pkgs.path + "/nixos/lib/eval-config.nix") {
      # signal to use nixpkgs.system before: https://github.com/NixOS/nixpkgs/pull/220743
      system = null;
      modules = lib.flatten [
        beeModule
        locatedConfig
        extraConfig
        extra
      ];
    };
  bee = evaled.config.bee // {
    _evaled = eval { config._module.check = true; };
    _unchecked = eval { config._module.check = false; };
  };
in
{
  inherit bee;
  imports = [
    beeModule
    locatedConfig
    extraConfig
  ] ++ nixosModules;
}

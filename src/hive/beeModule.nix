# SPDX-FileCopyrightText: 2024 The divnix/hive Authors
#
# SPDX-License-Identifier: Unlicense

{ lib }:
{ config, ... }:
let
  l = lib // builtins;
in
{
  options.bee = {
    _alerts = l.mkOption {
      type = l.types.listOf l.types.unspecified;
      internal = true;
      default = [ ];
    };
    _evaled = l.mkOption {
      type = l.types.attrs;
      internal = true;
      default = { };
    };
    _unchecked = l.mkOption {
      type = l.types.attrs;
      internal = true;
      default = { };
    };
    system = l.mkOption {
      type = l.types.str;
      description = "omnibus/hive requires you to set the host's system via 'config.bee.system = \"x86_64-linux\";'";
    };
    home = l.mkOption {
      type = l.mkOptionType {
        name = "input";
        description = "home-manager input";
        check = x: (l.isAttrs x) && (l.hasAttr "sourceInfo" x);
      };
      description = "omnibus/hive requires you to set the home-manager input via 'config.bee.home = inputs.home-22-05;'";
    };
    wsl = l.mkOption {
      type = l.mkOptionType {
        name = "input";
        description = "nixos-wsl input";
        check = x: (l.isAttrs x) && (l.hasAttr "sourceInfo" x);
      };
      description = "omnibus/hive requires you to set the nixos-wsl input via 'config.bee.wsl = inputs.nixos-wsl;'";
    };
    darwin = l.mkOption {
      type = l.mkOptionType {
        name = "input";
        description = "darwin input";
        check = x: (l.isAttrs x) && (l.hasAttr "sourceInfo" x);
      };
      description = "omnibus/hive requires you to set the darwin input via 'config.bee.darwin = inputs.darwin;'";
    };
    colmena = l.mkOption {
      type = l.mkOptionType {
        name = "input";
        description = "colmena input";
        check = x: (l.isAttrs x) && (l.hasAttr "sourceInfo" x);
      };
      description = "omnibus/hive requires you to set the colmena input via 'config.bee.colmena = inputs.colmena;'";
    };
    pkgs = l.mkOption {
      type = l.mkOptionType {
        name = "packages";
        description = "instance of nixpkgs";
        check = x: (l.isAttrs x) && (l.hasAttr "path" x);
      };
      description = "omnibus/hive requires you to set the nixpkgs instance via 'config.bee.pkgs = inputs.nixos-22.05.legacyPackages;'";
      apply =
        x: if (l.hasAttr "${config.bee.system}" x) then x.${config.bee.system} else x;
    };
  };
}

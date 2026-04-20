# SPDX-FileCopyrightText: 2026 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  inputs,
  omnibus,
  lib,
  super,
}:
let
  inherit
    (omnibus.errors.requiredInputsLazily inputs "omnibus.pops.configs" [
      "nixpkgs"
      "nixago"
    ])
    nixago
    nixpkgs
    ;

  /**
    Reuse the repository's existing nixago wiring so a hook can consume the
    same generated `cog.toml` and package passthru metadata as other configs.
  */
  mkNixago =
    (omnibus.pops.self.addLoadExtender {
      load.inputs.inputs = {
        inherit
          nixago
          nixpkgs
          ;
      };
    }).exports.default.ops.mkNixago;

  /**
    Build a custom `git-hooks.nix` hook entry that is explicit about its runner
    so `pkgs.prek` can install it without a separate wrapper layer.
  */
  mkSystemHook =
    {
      name,
      entry,
      files ? "",
      stages ? [ "pre-commit" ],
      pass_filenames ? true,
      always_run ? false,
      description ? null,
      excludes ? [ ],
    }:
    {
      enable = true;
      inherit
        always_run
        entry
        excludes
        files
        name
        pass_filenames
        stages
        ;
      language = "system";
    }
    // lib.optionalAttrs (description != null) { inherit description; };
in
{
  cog = rec {
    nixago = (mkNixago super."nixago-cog") super.cog.default;
    packages = [ nixpkgs.cocogitto ];
    git-hooks.hooks.cocogitto-verify = mkSystemHook {
      name = "cocogitto";
      description = "Validate commit messages with cocogitto";
      entry = "${nixpkgs.cocogitto}/bin/cog --config ${nixago.configFile} verify --ignore-merge-commits --ignore-fixup-commits --file";
      stages = [ "commit-msg" ];
      always_run = true;
    };
  };

  nickel = {
    packages = [ nixpkgs.nickel ];
    git-hooks.hooks.nickel-format = mkSystemHook {
      name = "nickel";
      entry = "${nixpkgs.nickel}/bin/nickel format --";
      files = "\\.ncl$";
      excludes = [ "\\.schema\\.ncl$" ];
    };
  };

  topiary = {
    packages = [ nixpkgs.topiary ];
    git-hooks.hooks.topiary = mkSystemHook {
      name = "topiary";
      entry = "${nixpkgs.topiary}/bin/topiary format";
      files = "\\.toml$";
    };
  };

  just = {
    packages = [ nixpkgs.just ];
    git-hooks.hooks.justfmt = mkSystemHook {
      name = "justfmt";
      entry = "${nixpkgs.just}/bin/just --fmt --unstable --justfile";
      files = "^justfile$";
    };
  };
}

# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  super,
  root,
  projectRoot,
  inputs,
  lib,
}:
let
  outputs = root.lib.omnibus.mapPopsExports super.pops;
  supportedSystems = lib.genAttrs [
    "x86_64-linux"
    "aarch64-linux"
    "aarch64-darwin"
  ];
  /**
    Keep the system-specific nixpkgs lookup in one place so every exported
    per-system surface shares the same resolution path.
  */
  systemNixpkgs = system: super.pops.flake.inputs.nixpkgs.legacyPackages.${system};
  /**
    Most per-system exports differ only by the load selectors and exported
    surface name, so centralize the `addLoadExtender` pattern here.
  */
  perSystemPopExport =
    pop: exportName: loadFn:
    supportedSystems (
      system:
      (pop.addLoadExtender {
        load = loadFn system;
      }).exports.${exportName}
    );
in
{
  inherit (super) load;
  inherit (outputs)
    srvos
    nixosModules
    nixosProfiles
    darwinModules
    darwinProfiles
    homeProfiles
    homeModules
    devshellModules
    devshellProfiles
    flake
    jupyenv
    systemManagerProfiles
    ;

  scripts = perSystemPopExport super.pops.scripts "default" (system: {
    inputs = {
      inputs = {
        nixpkgs = systemNixpkgs system;
        inherit (super.pops.flake.inputs) makesSrc;
      };
    };
  });

  packages = perSystemPopExport super.pops.packages "derivations" (system: {
    src = projectRoot + "/units/packages";
    inputs = {
      inputs = {
        nixpkgs = systemNixpkgs system;
      };
    };
  });

  units = {
    inherit (outputs) configs std jupyenv;

    nixos = {
      inherit (outputs)
        nixosProfiles
        nixosModules
        homeProfiles
        homeModules
        ;
    };

    learn = perSystemPopExport super.pops.load "default" (system: {
      src = projectRoot + "/units/learn";
      inputs = {
        inputs = {
          nixpkgs = systemNixpkgs system;
        };
      };
    });
    darwin = {
      inherit (outputs) darwinProfiles darwinModules;
    };
    home-manager = {
      inherit (outputs) homeProfiles homeModules;
    };
    flake-parts = {
      inherit (outputs.flake-parts) profiles modules;
    };
    devshell = {
      inherit (outputs) devshellProfiles devshellModules;
    };
  };

  dotfiles = projectRoot + "/dotfiles";

  # aliases
  flakeModules = outputs.flake-parts.modules;
  flakeProfiles = outputs.flake-parts.profiles;
}

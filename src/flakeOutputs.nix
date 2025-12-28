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

  scripts = supportedSystems (
    system:
    (super.pops.scripts.addLoadExtender {
      load.inputs = {
        inputs = {
          nixpkgs = super.pops.flake.inputs.nixpkgs.legacyPackages.${system};
          inherit (super.pops.flake.inputs) makesSrc;
        };
      };
    }).exports.default
  );

  packages = supportedSystems (
    system:
    (super.pops.packages.addLoadExtender {
      load = {
        src = projectRoot + "/units/packages";
        inputs = {
          inputs = {
            nixpkgs = super.pops.flake.inputs.nixpkgs.legacyPackages.${system};
          };
        };
      };
    }).exports.derivations
  );

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

    learn = supportedSystems (
      system:
      (super.pops.load.addLoadExtender {
        load = {
          src = projectRoot + "/units/learn";
          inputs = {
            inputs = {
              nixpkgs = super.pops.flake.inputs.nixpkgs.legacyPackages.${system};
            };
          };
        };
      }).exports.default
    );
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
  flakeModules = outputs.flake-parts.profiles;
  flakeProfiles = outputs.flake-parts.modules;

  devShells = (inputs.self.call-flake (projectRoot + "/local")).devShells;
}

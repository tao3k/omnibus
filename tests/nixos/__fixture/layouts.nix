# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

let
  inherit (inputs) nixpkgs darwin;
  # exports.default to be default
  outputs = omnibus.lib.mapPopsExports' super.pops;
  # with multi-layout
  outputs' = omnibus.lib.mapPopsExports super.pops;
in
{
  system = "x86_64-linux";

  inherit data outputs outputs';

  nixosSuites = lib.flatten [
    outputs.selfNixOSProfiles.default.bootstrap

    # self.nixosProfiles.default.presets.boot
    # load a suite profile from audio
    # (outputs.nixosProfiles.default.audio {}).default

    # # --custom profiles
    outputs.nixosProfiles.customProfiles.presets.nix
    # # exporter.nixosProfiles.customProfiles.presets.boot
    # outputs.srvos.default.common.nix

    (outputs'.omnibus.mkHome inputs.home-manager.nixosModule
      {
        admin = {
          uid = 1000;
          description = "default manager";
          isNormalUser = true;
          extraGroups = ["wheel"];
        };
      }
      "zsh"
      self.homeSuites
    )
  ];

  homeSuites = [
    # exporter.homeProfiles.default.presets.bat
    # # The parent directory of "presets" is categorized as a list type of "suites"
    outputs.homeProfiles.omnibus.shell.default
    # super.pops.homeModules.exports.default.wayland.windowManager.hyprland
  ];

  nixosConfiguration =
    module:
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = lib.flatten [
        self.nixosSuites
        module
      ];
    };

  darwinConfiguration =
    module:
    darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = lib.flatten [module];
    };
}

# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ self, lib }:
# let
#   outputs = inputs.self;
# in
# {
#   system = "aarch64-aarch";

#   data = outputs.local.${self.system}.data;

#   hive = {
#     bee.system = self.system;
#     bee.home = inputs.home-manager;
#     bee.darwin = inputs.darwin;
#     bee.pkgs = import inputs.nixpkgs { inherit (self) system; };
#     imports = lib.flatten self.darwinSuites;
#   };

#   darwinSuites = lib.flatten [
#     # outputs.darwinModules.exports.default.homebrew
#     # # # --custom profiles
#     # outputs.pops.nixosProfiles.exports.customProfiles.presets.nix
#     # outputs.pops.nixosProfiles.exports.customProfiles.presets.boot
#     # outputs.pops.nixosModules.exports.customModules.boot

#     # outputs.srvos.default.common.nix
#     (outputs.omnibus.mkHome inputs.home.darwinModule {
#       admin = {
#         uid = 1000;
#         description = "default manager";
#       };
#     } "zsh" self.homeSuites)
#   ];

#   homeSuites = [
#     # outputs.homeProfiles.presets.emacs
#     # outputs.homeProfiles.presets.bat
#     # # # The parent directory of "presets" is categorized as a list type of "suites"
#     # (outputs.homeProfiles.shell { }).default
#   ];
{
}

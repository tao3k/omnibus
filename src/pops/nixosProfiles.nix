# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  super,
  projectRoot,
  POP,
  flops,
  lib,
}:
(super.nixosModules.addLoadExtender {
  load = {
    src = projectRoot + "/units/nixos/nixosProfiles";
    type = "nixosProfilesOmnibus";
    transformer = [ (_: _: _) ];
    inputsTransformer = [
      (
        self:
        self
        // (
          let
            system = if self ? system then self.system else throw "system is required";
          in
          {
            isDarwin = lib.elem system lib.systems.doubles.darwin;
            isLinux = lib.elem system lib.systems.doubles.linux;
          }
        )
      )
    ];
  };
}).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (_selfP: _super: { exports = { }; }))
  ]

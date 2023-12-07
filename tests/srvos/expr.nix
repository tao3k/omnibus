# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  trace,
  lib,
  root,
}:
let
  exporter = root.nixos.pops.exports.default;
in
{
  srvosCommonOpenssh =
    (exporter.layouts.nixosConfiguration [
      exporter.layouts.outputs.nixosProfiles.default.presets.boot
      # -- suites profile --
      exporter.layouts.outputs.nixosProfiles.default.cloud.default
    ]).config.services.openssh.settings.KexAlgorithms;
}
// lib.optionalAttrs trace {}

# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  pkgs,
  config,
  omnibus,
  ...
}:
let
  cfg = config.omnibus.coding.conf;
in
{
  imports = [ omnibus.nixosModules.omnibus.coding.conf ];
  environment.systemPackages =
    with pkgs;
    lib.optionals cfg.enableLsp [ yaml-language-server ];
}

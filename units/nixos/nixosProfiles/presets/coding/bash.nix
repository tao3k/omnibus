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
  cfg = config.omnibus.coding.bash;
in
{
  imports = [ omnibus.nixosModules.omnibus.coding.bash ];
  environment.systemPackages =
    with pkgs;
    [ shellcheck ]
    ++ lib.optionals cfg.enableLsp [ nodePackages.bash-language-server ];
}

# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  omnibus,
  lib,
  config,
}:
let
  cfg = config.omnibus.bootstrap;
in
{
  imports = [ omnibus.nixosModules.omnibus.bootstrap ];
  config = {
    omnibus.bootstrap.PATH = lib.mkBefore [
      "/run/current-system/sw/bin"
      "/etc/profiles/per-user/$USER/bin"
      "/opt/homebrew/bin"
      "/bin/"
      "/usr/bin"
      "/usr/sbin"
      "/usr/local/bin"
      "/usr/sbin"
      "/sbin"
    ];
    environment.systemPath = [ ];
    environment.variables.PATH = cfg.PATH;
  };
}

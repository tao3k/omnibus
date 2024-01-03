# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  super,
  projectRoot,
  haumea,
  lib,
  root,
}:
super.nixosProfiles.addLoadExtender {
  load = {
    src = projectRoot + "/units/devshell/profiles";
    type = "nixosProfiles";
    loader = with haumea; [
      (matchers.nix loaders.default)
      (matchers.regex "^(.+)\\.(toml)$" (
        _matches: inputs: path:
        let
          inherit
            (root.errors.requiredInputs inputs.inputs "omnibus.pops.devshellProfiles" [
              "devshell"
            ])
            devshell
            ;
        in
        devshell.lib.importTOML path
      ))
    ];
  };
}

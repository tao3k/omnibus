# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  super,
  projectRoot,
  haumea,
  lib,
  inputs,
}:
super.nixosProfiles.addLoadExtender {
  load = {
    src = projectRoot + "/units/devshell/profiles";
    type = "nixosProfiles";
    loader =
      with haumea;
      [ (matchers.nix loaders.default) ]
      ++ lib.optionals (inputs ? devshell) [
        (matchers.regex "^(.+)\\.(toml)$" (
          _matches: _: path:
          inputs.devshell.lib.importTOML path
        ))
      ];
  };
}

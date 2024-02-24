# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

writeShellApplication {
  name = "nvfetcher-update";
  runtimeInputs = [ nixpkgs.nvfetcher ];
  text = nixpkgs.lib.fileContents ./entrypoint.sh;
}

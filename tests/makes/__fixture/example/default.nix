# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

makeScript {
  name = "runScriptWithEnv";
  searchPaths.bin = [ nixpkgs.awscli ];
  searchPaths.source = [ ./env ];
  entrypoint = ./entrypoint.sh;
}

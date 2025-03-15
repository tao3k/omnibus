# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT
let
  inherit (nixpkgs) mkShell;
in
mkShell {
  buildInputs = root.hello-tf.passthru.runtimeInputs;
}

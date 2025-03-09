# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT
let
  inherit (nixpkgs) terraform-providers;
  inherit (omnibus.flake.inputs) tf-ncl;
  github-users = p: {
    inherit (p) null;
    # inherit (terraform-providers) github;
  };
  terraform =
    (import nixpkgs.path {
      config.allowUnfree = true;
      inherit (nixpkgs) system;
    }).terraform;
in
omnibus.ops.mkTfNcl {
  inherit nixpkgs tf-ncl terraform;
} "hello-tf" github-users { }
# nix run .#scripts.aarch64-darwin.hello-tf ./units/scripts/hello-tf/hello/hello-tf.ncl init

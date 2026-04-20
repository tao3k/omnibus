# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ super, lib }:
{
  nixpkgs,
  tf-ncl,
  terraform ? nixpkgs.opentofu,
}:
let
  writeShellApplication = super.writeShellApplication { inherit nixpkgs; };
in
name: tfPlugins: git:
let
  inherit (nixpkgs.stdenv) system;
  inherit (tf-ncl.inputs) nickel;

  terraformProviders = nixpkgs.terraform-providers.actualProviders;

  terraform-with-plugins = terraform.withPlugins (p: nixpkgs.lib.attrValues (tfPlugins p));

  generateJsonSchema =
    terraform: providerFn:
    nixpkgs.callPackage (import ./_terraform-schema.nix (providerFn terraformProviders)) {
      inherit terraform;
      inherit (tf-ncl.packages.${system}) schema-merge;
    };

  generateSchema =
    terraform: providerFn:
    nixpkgs.callPackage (tf-ncl + /nix/nickel_schema.nix) {
      jsonSchema = (generateJsonSchema terraform) providerFn;
      inherit (tf-ncl.packages.${system}) tf-ncl;
    };

  devshell = nixpkgs.callPackage ./_tf-ncl-devshell.nix {
    inherit terraform generateSchema nickel;
  };
  /**
    Reuse the provider-aware devshell package set for both passthru metadata
    and runtime inputs so we only evaluate it once.
  */
  devshellPackages = devshell { providers = tfPlugins; };
  ncl-schema = generateSchema terraform tfPlugins;
  terraformExe = lib.getExe terraform-with-plugins;
in
writeShellApplication {
  inherit name;
  runtimeEnv = {
    TF_IN_AUTOMATION = 1;
    TF_PLUGIN_CACHE_DIR = "$PRJ_CACHE_HOME/tf-plugin-cache";
  };
  passthru = {
    devshellDeps = devshellPackages;
  };
  runtimeInputs =
    with nixpkgs;
    [
      nickel.packages.${system}.default
      terraform-with-plugins
      terraform-backend-git
    ]
    ++ nixpkgs.lib.attrValues devshellPackages;
  text = ''
    set -e

    # Keep all generated state under project-owned data/cache roots.
    TF_NCL_DIR="$PRJ_DATA_DIR/tf-ncl/${name}"
    TF_PLUGIN_CACHE_DIR="$PRJ_CACHE_HOME/tf-plugin-cache"

    mkdir -p "$TF_NCL_DIR"
    mkdir -p "$TF_PLUGIN_CACHE_DIR"

    if [[ "$#" -le 1 ]]; then
      echo "terraform <ncl-file> ..."
      exit 1
    fi
    ENTRY="''${1}"
    shift
    ln -snfT ${ncl-schema} "$TF_NCL_DIR/schema.ncl"
    nickel export > "$TF_NCL_DIR/main.tf.json" <<EOF
      (import "''${ENTRY}").renderable_config
    EOF

    ${
      if git != { } then
        ''
          ENTRY_DIR="$(dirname "$ENTRY")"

          terraform-backend-git git \
             --dir "$TF_NCL_DIR" \
             --repository ${git.repo} \
             --ref ${git.ref} \
             --state "''${ENTRY_DIR}/state.json" \
             ${terraformExe} "$@"
        ''
      else
        ''
          ${terraformExe} -chdir="$TF_NCL_DIR" "$@"
        ''
    }
  '';
}

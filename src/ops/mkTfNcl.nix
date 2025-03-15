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

  terraform-with-plugins = terraform.withPlugins (
    p: nixpkgs.lib.attrValues (tfPlugins p)
  );

  generateJsonSchema =
    terraform: providerFn:
    nixpkgs.callPackage
      (import ./_terraform-schema.nix (providerFn terraformProviders))
      {
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
  ncl-schema = generateSchema terraform tfPlugins;
in
writeShellApplication {
  inherit name;
  runtimeEnv = {
    TF_IN_AUTOMATION = 1;
    TF_PLUGIN_CACHE_DIR = "$PRJ_CACHE_HOME/tf-plugin-cache";
  };
  passthru = {
    devshellDeps = devshell { providers = tfPlugins; };
  };
  runtimeInputs = with nixpkgs; [
    nickel.packages.${system}.default
    terraform-with-plugins
    terraform-backend-git
    (nixpkgs.lib.attrValues (devshell {
      providers = tfPlugins;
    }))
  ];
  text = ''
    set -e

    if [[ ! -d "$PRJ_DATA_DIR"/tf-ncl/${name} ]]; then
       mkdir -p "$PRJ_DATA_DIR"/tf-ncl/${name}
       mkdir -p "$PRJ_CACHE_HOME"/tf-plugin-cache
    fi

    if [[ "$#" -le 1 ]]; then
      echo "terraform <ncl-file> ..."
      exit 1
    fi
    ENTRY="''${1}"
    shift
    ln -snfT ${ncl-schema} "$PRJ_DATA_DIR"/tf-ncl/${name}/schema.ncl
    nickel export > "$PRJ_DATA_DIR"/tf-ncl/${name}/main.tf.json <<EOF
      (import "''${ENTRY}").renderable_config
    EOF

    ${
      if git != { } then
        ''
          ENTRY_DIR="$(dirname "$ENTRY")"

          terraform-backend-git git \
             --dir "$PRJ_DATA_DIR"/tf-ncl/${name} \
             --repository ${git.repo} \
             --ref ${git.ref} \
             --state "''${ENTRY_DIR}/state.json" \
             ${lib.getExe terraform-with-plugins} "$@"
        ''
      else
        ''
          ${lib.getExe terraform-with-plugins} -chdir="$PRJ_DATA_DIR"/tf-ncl/${name} "$@"
        ''
    }
  '';
}

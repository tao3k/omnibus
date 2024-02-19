# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ root }: # source from std
nixpkgs:
let
  inherit (builtins) fromJSON;
  inherit (nixpkgs) runCommand yq-go;
  inherit (nixpkgs.lib) readFile;
in
# Read a YAML file into a Nix datatype using IFD.
# Similar to:
# > builtins.fromJSON (builtins.readFile ./somefile)
# but takes an input file in YAML instead of JSON.
#
# Type:
#   Path -> a :: Nix
path:
let
  jsonOutputDrv = runCommand "from-yaml" {
    nativeBuildInputs = [ yq-go ];
  } ''yq -o=json "${path}" > "$out"'';
in
fromJSON (readFile jsonOutputDrv)

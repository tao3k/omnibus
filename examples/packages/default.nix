# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

# [[file:../../docs/org/pops-packages.org::*Example][Example:1]]
{ omnibus, inputs }:
let
  nixpkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in
(omnibus.pops.packages {
  src = ./__fixture;
  inputs = {
    inputs = {
      inherit nixpkgs;
      source = import ./_sources/generated.nix {
        inherit (nixpkgs)
          fetchgit
          fetchurl
          fetchFromGitHub
          dockerTools
        ;
      };
    };
  };
})
# => out.exports { default = {...}, packages = {...}; }
# Example:1 ends here

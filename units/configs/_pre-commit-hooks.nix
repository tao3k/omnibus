# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ inputs, omnibus }:
let
  inherit
    (omnibus.errors.requiredInputsLazily inputs "omnibus.pops.configs" [
      "nixpkgs"
      "pre-commit-hooks"
    ])
    nixpkgs
    pre-commit-hooks
    ;
  inherit (nixpkgs) lib;
  builtinStuff = {
    tools = pre-commit-hooks.packages;
  };
  gitignore-nix-src = pre-commit-hooks.inputs.gitignore;
in
{
  src,
  hooks ? { },
  excludes ? [ ],
  tools ? { },
  settings ? { },
  isFlakes ? true,
  default_stages ? [ "commit" ],
}:
let
  project = lib.evalModules {
    modules = [
      (pre-commit-hooks + /modules/all-modules.nix)
      {
        config =
          {
            _module.args.pkgs = nixpkgs;
            _module.args.gitignore-nix-src = gitignore-nix-src;
            inherit
              hooks
              excludes
              settings
              default_stages
              ;
            tools = builtinStuff.tools // tools;
            package = nixpkgs.pre-commit;
          }
          // (
            if isFlakes then
              { rootSrc = src; }
            else
              { rootSrc = gitignore-nix-src.lib.gitignoreSource src; }
          );
      }
    ];
  };
  inherit (project.config) installationScript;
in
project.config

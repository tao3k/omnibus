# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ inputs, omnibus }:
let
  inherit
    (omnibus.errors.requiredInputsLazily inputs "omnibus.pops.configs" [
      "nixpkgs"
      "git-hooks"
    ])
    nixpkgs
    git-hooks
    ;
  inherit (nixpkgs) lib;

  builtinStuff = {
    tools = git-hooks.packages.${nixpkgs.stdenv.hostPlatform.system};
  };
  gitignore-nix-src = git-hooks.inputs.gitignore;
in
{
  src,
  imports ? [ ],
  tools ? { },
  isFlakes ? false,
  ...
}@options:
let
  moduleOptions = builtins.removeAttrs options [
    "imports"
    "tools"
  ];
  project = lib.evalModules {
    modules = [

      (git-hooks + /modules/all-modules.nix)
      {
        config = lib.mkMerge [
          moduleOptions
          {
            _module.args = {
              inherit gitignore-nix-src;
              pkgs = nixpkgs;
            };
            tools = lib.mkDefault (builtinStuff.tools // tools);
            rootSrc = if isFlakes then src else gitignore-nix-src.lib.gitignoreSource src;
          }
        ];
      }
    ]
    ++ imports;
  };
  inherit (project.config) installationScript;
in
project.config.run
// {
  inherit (project) config;
  inherit (project.config) enabledPackages shellHook;
}

# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  inputs,
  omnibus,
  super,
  self,
  lib,
}:
let
  inherit
    (omnibus.errors.requiredInputsLazily inputs "omnibus.pops.configs" [
      "nixpkgs"
      "nur"
      "git-hooks"
    ])
    nixpkgs
    nur
    git-hooks
    ;
  languagetool-code-comments =
    (nixpkgs.extend nur.overlay)
    .nur.repos.dustinblackman.languagetool-code-comments;

  hooksFn =
    cfg:
    (super.git-hooks {
      src = ./.;
      settings = cfg;
    }).hooks;
in
{
  git-hooks = {
    __functor = _: settings: hooksFn settings;
    typos =
      (hooksFn {
        typos = {
          format = "brief";
          locale = "en";
        };
      }).typos;
  };
  default = {
    packages =
      [ nixpkgs.jq ]
      ++ (map (x: git-hooks.packages.${x}) (
        lib.attrNames (removeAttrs self.git-hooks [ "__functor" ])
      ));
    data = {
      commit-msg = {
        commands = {
          conform = {
            # allow WIP, fixup!/squash! commits locally
            run = ''
              [[ "$(head -n 1 {1})" =~ ^WIP(:.*)?$|^wip(:.*)?$|fixup\!.*|squash\!.* ]] ||
              conform enforce --commit-msg-file {1}'';
            skip = [
              "merge"
              "rebase"
            ];
          };
        };
      };
      pre-commit = {
        commands = {
          hunspell = {
            run = "${
              (nixpkgs.hunspellWithDicts [ nixpkgs.hunspellDicts.en-us ])
            }/bin/hunspell -l {staged_files}";
            glob = "*.{txt,md,html,xml,rst,tex,odf,org}"; # spellchecker:disable-line
            skip = [
              "merge"
              "rebase"
            ];
          };
          typos = {
            # run = "typos --format brief {staged_files}";
            run = self.git-hooks.typos.entry + "  {staged_files}";
            skip = [
              "merge"
              "rebase"
            ];
          };
          treefmt = {
            run = "treefmt --fail-on-change {staged_files}";
            skip = [
              "merge"
              "rebase"
            ];
          };
        };
      };
    };
  };
  languagetool-code-comments = {
    packages = [ languagetool-code-comments ];
  };
  just = {
    packages = [ nixpkgs.just ];
    data = {
      pre-commit = {
        commands = {
          justfmt = {
            run = "just --fmt --unstable";
            skip = [
              "merge"
              "rebase"
            ];
          };
        };
      };
    };
  };
}

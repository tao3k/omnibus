# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ inputs, omnibus }:
let
  inherit
    (omnibus.errors.requiredInputs inputs "omnibus.pops.configs" [
      "nixpkgs"
      "nur"
    ])
    nixpkgs
    nur
  ;
  languagetool-code-comments =
    (nixpkgs.extend nur.overlay)
    .nur.repos.dustinblackman.languagetool-code-comments;
in
{
  default = {
    packages = [ nixpkgs.jq ];
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
          # languagetool-code-comments = {
          #   run = "languagetool-code-comments check -f {staged_files} -l en-US";
          #   glob = "*.{js,ts,jsx,tsx,nix}";
          #   skip = [
          #     "merge"
          #     "rebase"
          #   ];
          # };
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
}

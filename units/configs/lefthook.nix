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

  mkHooks =
    cfg:
    (super.git-hooks {
      src = ./.;
      imports = [ cfg ];
    }).config;
in
{
  git-hooks = {
    __functor = _: settings: mkHooks settings;
    settings = (
      mkHooks {
        hooks.typos.enable = true;
        hooks.typos.settings = {
          format = "brief";
          locale = "en";
        };
      }
    );
  };

  default = {
    packages = [
      nixpkgs.jq
    ]
    ++ self.git-hooks.settings.enabledPackages;
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
              (nixpkgs.hunspell.withDicts (dicts: [
                dicts.en-us
              ]))
            }/bin/hunspell -l {staged_files}
            ";
            glob = "*.{txt,md,html,xml,rst,tex,odf,org}"; # spellchecker:disable-line
            skip = [
              "merge"
              "rebase"
            ];
          };
          typos = {
            # run = "typos --format brief {staged_files}";
            run = self.git-hooks.settings.hooks.typos.entry + " {staged_files}";
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

  nickel = {
    packages = [ nixpkgs.nickel ];
    data = {
      pre-commit = {
        commands = {
          nickel = {
            glob = "*.ncl";
            exclude = [ "*.schema.ncl" ];
            run = "nickel format {staged_files}";
            skip = [
              "merge"
              "rebase"
            ];
          };
        };
      };
    };
  };

  nix = {
    packages = [ nixpkgs.nixfmt-rfc-style ];
    data = {
      pre-commit = {
        commands = {
          nixfmt = {
            glob = "*.nix";
            exclude = [ "generated.nix" ];
            run = "nixfmt --width=80 {staged_files}";
            skip = [
              "merge"
              "rebase"
            ];
          };
        };
      };
    };
  };

  prettier = {
    packages = [ nixpkgs.nodePackages.prettier ];
    data = {
      pre-commit = {
        commands = {
          prettier = {
            glob = "*.{css,html,js,json,jsx,md,mdx,scss,ts,yaml}";
            exclude = [ "generated.json" ];
            run = "prettier --write {staged_files}";
            skip = [
              "merge"
              "rebase"
            ];
          };
        };
      };
    };
  };

  shell = {
    packages = [ nixpkgs.shfmt ];
    data = {
      pre-commit = {
        commands = {
          shfmt = {
            glob = "*.{sh,bash}";
            run = "shfmt -i 2 -s -w {staged_files}";
            skip = [
              "merge"
              "rebase"
            ];
          };
        };
      };
    };
  };

  topiary = {
    packages = [ nixpkgs.topiary ];
    data = {
      pre-commit = {
        commands = {
          topiary = {
            glob = "*.toml";
            run = "topiary format {staged_files}";
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

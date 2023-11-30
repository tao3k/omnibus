# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{inputs, omnibus}:
let
  inherit
    (omnibus.errors.requiredInputs inputs "omnibus.pops.configs" [
      "nixpkgs"
      "topiary"
      "nixfmt"
      "dmerge"
    ])
    dmerge
    topiary
    nixpkgs
    nixfmt
    ;
  inherit (dmerge) prepend;
in
{
  default = {
    packages = [
      nixfmt.packages.default
      nixpkgs.nodePackages.prettier
      nixpkgs.shfmt
      nixpkgs.nodePackages.prettier-plugin-toml
    ];
    data = {
      formatter = {
        nix = {
          includes = ["*.nix"];
          command = "nixfmt";
          options = ["--width=80"];
          excludes = [];
        };
        prettier = {
          command = "prettier";
          options = [
            "--plugin"
            "${nixpkgs.nodePackages.prettier-plugin-toml}/lib/node_modules/prettier-plugin-toml/lib/api.js"
            "--write"
          ];
          includes = [
            "*.css"
            "*.html"
            "*.js"
            "*.json"
            "*.jsx"
            "*.md"
            "*.mdx"
            "*.scss"
            "*.ts"
            "*.yaml"
            "*.toml"
          ];
        };
        shell = {
          command = "shfmt";
          options = [
            "-i"
            "2"
            "-s"
            "-w"
          ];
          includes = ["*.sh"];
        };
      };
    };
  };
  julia = {
    data.formatter.prettier = {
      includes = prepend [""];
      excludes = prepend [
        "Manifest.toml"
        "Project.toml"
        "julia2nix.toml"
      ];
    };
  };
  rust = {
    data.formatter.rust = {
      command = "rustfmt";
      includes = ["*.rs"];
      options = [
        "--edition"
        "2021"
      ];
    };
    data.formatter.prettier = {
      includes = prepend [".rustfmt.toml"];
    };
  };
  nvfetcher = {
    data.formatter.prettier = {
      excludes = prepend ["generated.json"];
    };
    data.formatter.nix = {
      excludes = prepend ["generated.nix"];
    };
  };
  nix = {
    data.formatter.prettier = {
      excludes = prepend [".nix.toml"];
    };
  };
  nickel = {
    data.formatter.nickel = {
      command = "nickel";
      options = ["format"];
      includes = ["*.ncl"];
    };
  };
  deadnix = {
    packages = [nixpkgs.deadnix];
    data.formatter.deadnix = {
      command = "deadnix";
      options = ["--edit"];
    };
  };
  topiary = {
    data.formatter.topiary = {
      command = "topiary";
      options = ["format"];
      includes = ["*.ncl"];
    };
    packages = [topiary.packages.default];
  };
}

# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  inputs,
  omnibus,
  lib,
}:
let
  inherit
    (omnibus.errors.requiredInputsLazily inputs "omnibus.pops.configs" [
      "nixpkgs"
      "nixfmt"
      "dmerge"
      "topiary"
    ])
    dmerge
    nixfmt
    topiary
    nixpkgs
    ;
  inherit (dmerge) prepend;
in
{
  default = {
    packages = [
      nixfmt.packages.default
      nixpkgs.shfmt
      nixpkgs.nodePackages.prettier
    ];
    data = {
      formatter = {
        nix = {
          includes = [ "*.nix" ];
          command = "nixfmt";
          options = [ "--width=80" ];
          excludes = [ ];
        };
        prettier = {
          command = "prettier";
          options = [
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
          includes = [
            "*.sh"
            "*.bash"
          ];
        };
      };
    };
  };
  julia = {
    data.formatter.prettier = {
      includes = prepend [ "" ];
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
      includes = [ "*.rs" ];
      options = [
        "--edition"
        "2021"
      ];
    };
    data.formatter.prettier = {
      includes = prepend [ ".rustfmt.toml" ];
    };
  };
  nvfetcher = {
    data.formatter.prettier = {
      excludes = prepend [ "generated.json" ];
    };
    data.formatter.nix = {
      excludes = prepend [ "generated.nix" ];
    };
  };
  nix = {
    data.formatter.prettier = {
      excludes = prepend [ ".nix.toml" ];
    };
  };
  nickel = {
    data.formatter.nickel = {
      command = "nickel";
      options = [ "format" ];
      includes = [ "*.ncl" ];
      excludes = [ "*.schema.ncl" ];
    };
  };
  deadnix = {
    packages = [ nixpkgs.deadnix ];
    data.formatter.deadnix = {
      command = "deadnix";
      options = [ "--edit" ];
    };
  };
  topiary = {
    data.formatter.topiary = {
      command = "topiary";
      options = [ "format" ];
      includes = [
        "*.toml"
        # "*.bash"
        # "*.sh"
      ];
    };
    packages = [ topiary.packages.default ];
  };
  just = {
    data.formatter.just = {
      command = "just";
      options = [
        "--fmt"
        "--unstable"
        "--justfile"
      ];
      includes = [ "justfile" ];
    };
  };
}

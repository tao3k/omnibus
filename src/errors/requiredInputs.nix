# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ lib, super }:
inputs': object: listNames:
let
  /**
    Keep the missing-input list in the same order as the caller supplied it so
    the guidance reads naturally for the requested inputs.
  */
  notFoundInputs = lib.filter (name: !(lib.hasAttr name inputs')) listNames;
  msg = lib.concatMapStringsSep "\n         " (
    { name, url }:
    ''
      # please get the input from `${name}.url = "${url}"`
               ${name} = inputs.${name};
    ''
  ) (super.inputsSource notFoundInputs);

  /**
    `requiredInputs` expects a nixpkgs value that exposes `path` so downstream
    code can reuse either `legacyPackages.${system}` or `import nixpkgs.path`.
  */
  hasResolvedNixpkgs =
    !(lib.elem "nixpkgs" listNames)
    || (inputs' ? nixpkgs && lib.isAttrs inputs'.nixpkgs && inputs'.nixpkgs ? path);
in
assert lib.assertMsg (notFoundInputs == [ ]) ''
  please add these inputs to

      ${object}.addLoadExtender {
        load.inputs =
         inputs = {
           ${msg}
           # you can also see the full inputs list at
           # https://github.com/GTrunSec/omnibus/blob/main/units/lock/flake.nix#L1
         };
       };
'';
assert lib.assertMsg hasResolvedNixpkgs ''
  please add the following nixpkgs input to
      ${object}.addLoadExtender {
        load.inputs = {
          inputs = {
            nixpkgs = inputs.nixpkgs.legacyPackages.''${system} or (import inputs.nixpkgs.path);
          };
        };
     };
'';
inputs'

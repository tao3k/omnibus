# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{lib, super}:
inputs': object: listNames:
let
  notFoundInputs =
    (lib.filter (pair: pair != true) (
      map (v: if (lib.hasAttr v inputs') then true else v) listNames
    ));
  isFound = (lib.length notFoundInputs == 0);
  msg =
    (lib.concatMapStringsSep "\n         "
      (
        {name, url}:
        ''
          # please get the input from `${name}.url = "${url}"`
                   ${name} = inputs.${name};
        ''
      )
      (super.inputsSource notFoundInputs)
    );

  noSysNixpkgs =
    if (lib.elem "nixpkgs" listNames && inputs' ? nixpkgs) then
      if (lib.hasAttr "path" inputs'.nixpkgs) then true else false
    else if (lib.elem "nixpkgs" listNames && !inputs' ? nixpkgs) then
      false
    else
      true;
in
assert lib.assertMsg isFound ''
  please, add the these inputs into

      ${object}.addLoadExtender {
        load.inputs =
         inputs = {
           ${msg}
           # you can also see the full inputs list at
           # https://github.com/GTrunSec/omnibus/blob/main/local/lock/flake.nix#L1
         };
       };
'';
assert lib.assertMsg noSysNixpkgs ''
  please, add the following inputs into
      ${object}.addLoadExtender {
        load.inputs = {
          inputs = {
            nixpkgs = inputs.nixpkgs.legacyPackages.''${system} or (import inputs.nixpkgs.path);
          };
        };
     };
'';
inputs'

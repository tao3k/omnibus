{ lib, super }:
inputs': unit: listNames:
let
  fondInputs =
    if
      (lib.length (
        lib.filter (pair: pair == true) (map (v: lib.hasAttr v inputs') listNames)
      )) > 0
    then
      true
    else
      false
  ;
  msg =
    (lib.concatMapStringsSep "\n         "
      (
        { name, url }:
        ''
          # please get the input from `${name}.url = "${url}"`
                   ${name} = inputs.${name};
        ''
      )
      (super.inputsSource listNames)
    );

  noSysNixpkgs =
    if (lib.elem "nixpkgs" listNames) then
      if (lib.hasAttr "path" inputs'.nixpkgs) then true else false
    else
      true
  ;
in
assert lib.assertMsg fondInputs ''
  please, add the these inputs into

      omnibus.${unit}.addLoadExtender {
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
      omnibus.lib.addLoadExtender {
        load.inputs = {
          nixpkgs = inputs.nixpkgs.legacyPackages.''${system} or (import inputs.nixpkgs.path);
        };
     };
  }
'';
inputs'

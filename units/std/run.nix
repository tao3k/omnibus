{ root, inputs }:
let
  inherit (inputs.std.inputs) nixpkgs;
  inherit (root) mkCommand;
  contextFreeDrv = _: target: builtins.unsafeDiscardStringContext target.drvPath;
  inherit (nixpkgs.lib) getName;
in
# this is the exact sequence mentioned by the `nix run` docs
# and so should be compatible
currentSystem: target:
let
  programName = target.meta.mainProgram or (getName target);
in
mkCommand currentSystem "run" "run it" [ ]
  ''(cd "$PRJ_ROOT" && ${
    target.program or "${target}/bin/${programName}"
  } "$@") ''
  { }

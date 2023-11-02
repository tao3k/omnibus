{
  omnibus,
  POP,
  flops,
  lib,
}:
let
  inputs =
    let
      baseInputs = omnibus.pops.flake.setInitInputs ./__lock;
    in
    ((baseInputs.addInputsExtender (
      POP.extendPop flops.flake.pops.inputsExtender (
        self: super: {
          inputs = baseInputs.inputs // {
            devshell = baseInputs.inputs.devshell.legacyPackages;
          };
        }
      )
    )).setSystem
      "x86_64-linux"
    ).inputs;

  devshellProfiles =
    (omnibus.pops.devshellProfiles.addLoadExtender {
      load.inputs = {
        inputs = {
          inherit (inputs) fenix nixpkgs;
        };
      };
    }).exports.default;

  shell = inputs.devshell.mkShell {
    name = "rust";
    imports = [ devshellProfiles.rust ];
  };
in
lib.mapAttrs (_: builtins.unsafeDiscardStringContext) { rust = shell; }

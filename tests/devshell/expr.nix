{
  omnibus,
  POP,
  flops,
  lib,
}:
let
  inputs =
    let
      baseInputs = omnibus.pops.loadInputs.setInitInputs ./__lock;
    in
    ((baseInputs.addInputsExtender (
      POP.lib.extendPop flops.lib.flake.pops.inputsExtender (
        self: super: {
          inputs = {
            devshell = baseInputs.outputs.devshell.legacyPackages;
            nixpkgs = baseInputs.outputs.nixpkgs.legacyPackages;
          };
        }
      )
    )).setSystem
      "x86_64-linux"
    ).outputs;

  devshellProfiles =
    (omnibus.pops.devshellProfiles.addLoadExtender {
      load.inputs = {
        inputs = {
          inherit (inputs) fenix nixpkgs;
        };
      };
    }).layouts.default;

  shell = inputs.devshell.mkShell {
    name = "rust";
    imports = [ devshellProfiles.rust ];
  };
in
lib.mapAttrs (_: builtins.unsafeDiscardStringContext) { rust = shell; }

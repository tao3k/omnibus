{
  omnibus,
  POP,
  flops,
  lib,
  inputs,
}:
let
  system = "x86_64-linux";
  flake.inputs =
    let
      flake = omnibus.pops.flake.setInitInputs ./__lock;
    in
    ((flake.addInputsExtender (
      POP.lib.extendPop flops.lib.flake.pops.inputsExtender (
        self: super: {
          inputs = {
            nixpkgs = flake.inputs.nixpkgs.legacyPackages;
          };
        }
      )
    )).setSystem
      system
    ).inputs;

  flakeProfiles =
    (omnibus.pops.flake-parts.profiles.addLoadExtender {
      load = {
        inputs = {
          inputs = {
            inherit (flake.inputs) chinookDb;
          };
        };
      };
    }).layouts.default.process-compose;

  mkFlake =
    flake.inputs.flake-parts.lib.mkFlake
      {
        inputs = flake.inputs // {
          # fake self argument to make sure that the flake is
          self = inputs.self;
        };
      }
      {
        systems = [ system ];
        imports = [ flake.inputs.process-compose-flake.flakeModule ];
        perSystem = { self', ... }: { imports = [ flakeProfiles.sqlite-example ]; };
      };
in
lib.mapAttrs (_: builtins.unsafeDiscardStringContext) {
  example = mkFlake.packages.${system}.sqlite-example;
}

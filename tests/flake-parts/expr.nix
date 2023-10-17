{
  omnibus,
  POP,
  flops,
  lib,
  inputs,
}:
let
  system = "x86_64-linux";
  __inputs__ =
    let
      loadInputs = omnibus.pops.loadInputs.setInitInputs ./__lock;
    in
    ((loadInputs.addInputsExtender (
      POP.lib.extendPop flops.lib.flake.pops.inputsExtender (
        self: super: {
          inputs = {
            nixpkgs = loadInputs.outputs.nixpkgs.legacyPackages;
          };
        }
      )
    )).setSystem
      system
    ).outputs;

  flakeProfiles =
    (omnibus.pops.flake-parts.profiles.addLoadExtender {
      load = {
        inputs = {
          inputs = {
            inherit (__inputs__) chinookDb;
          };
        };
      };
    }).layouts.default.process-compose;

  mkFlake =
    __inputs__.flake-parts.lib.mkFlake
      {
        inputs = __inputs__ // {
          # fake self argument to make sure that the flake is
          self = inputs.self;
        };
      }
      {
        systems = [ system ];
        imports = [ __inputs__.process-compose-flake.flakeModule ];
        perSystem = { self', ... }: { imports = [ flakeProfiles.sqlite-example ]; };
      };
in
lib.mapAttrs (_: builtins.unsafeDiscardStringContext) {
  example = mkFlake.packages.${system}.sqlite-example;
}
